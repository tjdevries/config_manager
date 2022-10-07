local lspconfig = vim.F.npcall(require, "lspconfig")
if not lspconfig then
  return
end

local imap = require("tj.keymap").imap
local nmap = require("tj.keymap").nmap
local autocmd = require("tj.auto").autocmd
local autocmd_clear = vim.api.nvim_clear_autocmds

local semantic = vim.F.npcall(require, "nvim-semantic-tokens")

local is_mac = vim.fn.has "macunix" == 1

local lspconfig_util = require "lspconfig.util"

local telescope_mapper = require "tj.telescope.mappings"
local handlers = require "tj.lsp.handlers"

local ts_util = require "nvim-lsp-ts-utils"

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local augroup_codelens = vim.api.nvim_create_augroup("custom-lsp-codelens", { clear = true })
local augroup_format = vim.api.nvim_create_augroup("custom-lsp-format", { clear = true })
local augroup_semantic = vim.api.nvim_create_augroup("custom-lsp-semantic", { clear = true })

local autocmd_format = function(async, filter)
  vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = 0,
    callback = function()
      vim.lsp.buf.format { async = async, filter = filter }
    end,
  })
end

local filetype_attach = setmetatable({
  go = function()
    autocmd_format(false)
  end,

  scss = function()
    autocmd_format(false)
  end,

  css = function()
    autocmd_format(false)
  end,

  rust = function()
    telescope_mapper("<space>wf", "lsp_workspace_symbols", {
      ignore_filename = true,
      query = "#",
    }, true)

    autocmd_format(false)
  end,

  racket = function()
    autocmd_format(false)
  end,

  typescript = function()
    autocmd_format(false, function(client)
      return client.name ~= "tsserver"
    end)
  end,
}, {
  __index = function()
    return function() end
  end,
})

local buf_nnoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  nmap(opts)
end

local buf_inoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  imap(opts)
end

local custom_attach = function(client, bufnr)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  buf_inoremap { "<c-s>", vim.lsp.buf.signature_help }

  buf_nnoremap { "<space>cr", vim.lsp.buf.rename }
  buf_nnoremap { "<space>ca", vim.lsp.buf.code_action }

  buf_nnoremap { "gd", vim.lsp.buf.definition }
  buf_nnoremap { "gD", vim.lsp.buf.declaration }
  buf_nnoremap { "gT", vim.lsp.buf.type_definition }

  buf_nnoremap { "<space>gI", handlers.implementation }
  buf_nnoremap { "<space>lr", "<cmd>lua R('tj.lsp.codelens').run()<CR>" }
  buf_nnoremap { "<space>rr", "LspRestart" }

  telescope_mapper("gr", "lsp_references", nil, true)
  telescope_mapper("gI", "lsp_implementations", nil, true)
  telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
  telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

  if filetype ~= "lua" then
    buf_nnoremap { "K", vim.lsp.buf.hover, { desc = "lsp:hover" } }
  end

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    autocmd_clear { group = augroup_highlight, buffer = bufnr }
    autocmd { "CursorHold", augroup_highlight, vim.lsp.buf.document_highlight, buffer = bufnr }
    autocmd { "CursorMoved", augroup_highlight, vim.lsp.buf.clear_references, buffer = bufnr }
  end

  if false and client.server_capabilities.codeLensProvider then
    if filetype ~= "elm" then
      autocmd_clear { group = augroup_codelens, buffer = bufnr }
      autocmd { "BufEnter", augroup_codelens, vim.lsp.codelens.refresh, bufnr, once = true }
      autocmd { { "BufWritePost", "CursorHold" }, augroup_codelens, vim.lsp.codelens.refresh, bufnr }
    end
  end

  local caps = client.server_capabilities
  if semantic and caps.semanticTokensProvider and caps.semanticTokensProvider.full then
    autocmd_clear { group = augroup_semantic, buffer = bufnr }
    autocmd { "TextChanged", augroup_semantic, vim.lsp.buf.semantic_tokens_full, bufnr }
  end

  -- Attach any filetype specific options to the client
  filetype_attach[filetype](client)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()

-- Completion configuration
require("cmp_nvim_lsp").update_capabilities(updated_capabilities)
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

-- Semantic token configuration
if semantic then
  semantic.setup {
    preset = "default",
    highlighters = { require "nvim-semantic-tokens.table-highlighter" },
  }

  semantic.extend_capabilities(updated_capabilities)
end

updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

local rust_analyzer, rust_analyzer_cmd = nil, { "rustup", "run", "nightly", "rust-analyzer" }
local has_rt, rt = pcall(require, "rust-tools")
if has_rt then
  local extension_path = vim.fn.expand "~/.vscode/extensions/sadge-vscode/extension/"
  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

  rt.setup {
    server = {
      cmd = rust_analyzer_cmd,
      capabilities = updated_capabilities,
      on_attach = custom_attach,
    },
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
    tools = {
      inlay_hints = {
        auto = false,
      },
    },
  }
else
  rust_analyzer = {
    cmd = rust_analyzer_cmd,
  }
end

local servers = {
  -- Also uses `shellcheck` and `explainshell`
  bashls = true,

  eslint = true,
  gdscript = true,
  -- graphql = true,
  html = true,
  pyright = true,
  vimls = true,
  yamlls = true,

  cmake = (1 == vim.fn.executable "cmake-language-server"),
  dartls = pcall(require, "flutter-tools"),

  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
    init_options = {
      clangdFileStatus = true,
    },
  },

  gopls = {
    -- root_dir = function(fname)
    --   local Path = require "plenary.path"
    --
    --   local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
    --   local absolute_fname = Path:new(fname):absolute()
    --
    --   if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
    --     return absolute_cwd
    --   end
    --
    --   return lspconfig_util.root_pattern("go.mod", ".git")(fname)
    -- end,

    settings = {
      gopls = {
        codelenses = { test = true },
      },
    },

    flags = {
      debounce_text_changes = 200,
    },
  },

  omnisharp = {
    cmd = { vim.fn.expand "~/build/omnisharp/run", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  },

  rust_analyzer = rust_analyzer,

  racket_langserver = true,

  elmls = true,
  cssls = true,
  tsserver = {
    init_options = ts_util.init_options,
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },

    on_attach = function(client)
      custom_attach(client)

      ts_util.setup { auto_inlay_hints = false }
      ts_util.setup_client(client)
    end,
  },
}

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  lspconfig[server].setup(config)
end

if is_mac then
  local sumneko_cmd, sumneko_env = nil, nil
  require("nvim-lsp-installer").setup {
    automatic_installation = false,
    ensure_installed = { "sumneko_lua", "gopls" },
  }

  sumneko_cmd = {
    vim.fn.stdpath "data" .. "/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server",
  }

  local process = require "nvim-lsp-installer.core.process"
  local path = require "nvim-lsp-installer.core.path"

  sumneko_env = {
    cmd_env = {
      PATH = process.extend_path {
        path.concat { vim.fn.stdpath "data", "lsp_servers", "sumneko_lua", "extension", "server", "bin" },
      },
    },
  }

  setup_server("sumneko_lua", {
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            -- vim
            "vim",

            -- Busted
            "describe",
            "it",
            "before_each",
            "after_each",
            "teardown",
            "pending",
            "clear",

            -- Colorbuddy
            "Color",
            "c",
            "Group",
            "g",
            "s",

            -- Custom
            "RELOAD",
          },
        },

        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    },
  })
else
  -- Load lua configuration from nlua.
  _ = require("nlua.lsp.nvim").setup(lspconfig, {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,

    root_dir = function(fname)
      if string.find(vim.fn.fnamemodify(fname, ":p"), "xdg_config/nvim/") then
        return vim.fn.expand "~/git/config_manager/xdg_config/nvim/"
      end

      -- ~/git/config_manager/xdg_config/nvim/...
      return lspconfig_util.find_git_ancestor(fname) or lspconfig_util.path.dirname(fname)
    end,

    globals = {
      -- Colorbuddy
      "Color",
      "c",
      "Group",
      "g",
      "s",

      -- Custom
      "RELOAD",
    },
  })
end

for server, config in pairs(servers) do
  setup_server(server, config)
end

--[ An example of using functions...
-- 0. nil -> do default (could be enabled or disabled)
-- 1. false -> disable it
-- 2. true -> enable, use defaults
-- 3. table -> enable, with (some) overrides
-- 4. function -> can return any of above
--
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, method, params, client_id, bufnr, config)
--   local uri = params.uri
--
--   vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, {
--       underline = true,
--       virtual_text = true,
--       signs = sign_decider,
--       update_in_insert = false,
--     }
--   )(err, method, params, client_id, bufnr, config)
--
--   bufnr = bufnr or vim.uri_to_bufnr(uri)
--
--   if bufnr == vim.api.nvim_get_current_buf() then
--     vim.lsp.diagnostic.set_loclist { open_loclist = false }
--   end
-- end
--]]

-- Set up null-ls
local use_null = true
if use_null then
  require("null-ls").setup {
    sources = {
      -- require("null-ls").builtins.formatting.stylua,
      -- require("null-ls").builtins.diagnostics.eslint,
      -- require("null-ls").builtins.completion.spell,
      -- require("null-ls").builtins.diagnostics.selene,
      require("null-ls").builtins.formatting.prettierd,
    },
  }
end

-- Can set this lower if needed.
-- require("vim.lsp.log").set_level "debug"
-- require("vim.lsp.log").set_level "trace"

return {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = updated_capabilities,
}
