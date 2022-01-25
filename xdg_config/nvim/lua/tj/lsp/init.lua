local imap = require("tj.keymap").imap
local nmap = require("tj.keymap").nmap

local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
  return
end

local lspconfig_util = require "lspconfig.util"

local nvim_status = require "lsp-status"

local telescope_mapper = require "tj.telescope.mappings"
local handlers = require "tj.lsp.handlers"

-- Can set this lower if needed.
-- require("vim.lsp.log").set_level "debug"
-- require("vim.lsp.log").set_level "trace"

local status = require "tj.lsp.status"
status.activate()

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local filetype_attach = setmetatable({
  go = function(client)
    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]
  end,

  rust = function()
    telescope_mapper("<space>wf", "lsp_workspace_symbols", {
      ignore_filename = true,
      query = "#",
    }, true)

    -- vim.cmd [[
    --   autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request {aligned = true, prefix = " » "}
    -- ]]

    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]
  end,
}, {
  __index = function()
    return function() end
  end,
})

local buf_nnoremap = function(opts)
  opts.buffer = 0
  nmap(opts)
end

local buf_inoremap = function(opts)
  opts.buffer = 0
  imap(opts)
end

local custom_attach = function(client)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  nvim_status.on_attach(client)

  buf_inoremap { "<c-s>", vim.lsp.buf.signature_help }

  buf_nnoremap { "<space>cr", vim.lsp.buf.rename }
  telescope_mapper("<space>ca", "lsp_code_actions", nil, true)

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
    buf_nnoremap { "K", vim.lsp.buf.hover }
  end

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
      augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufEnter ++once         <buffer> lua require"vim.lsp.codelens".refresh()
        autocmd BufWritePost,CursorHold <buffer> lua require"vim.lsp.codelens".refresh()
      augroup END
    ]]
  end

  -- Attach any filetype specific options to the client
  filetype_attach[filetype](client)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

-- TODO: check if this is the problem.
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

-- vim.lsp.buf_request(0, "textDocument/codeLens", { textDocument = vim.lsp.util.make_text_document_params() })

local servers = {
  gdscript = true,
  graphql = true,
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
    -- Required for lsp-status
    init_options = {
      clangdFileStatus = true,
    },
    handlers = nvim_status.extensions.clangd.setup(),
  },

  gopls = {
    root_dir = function(fname)
      local Path = require "plenary.path"

      local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
      local absolute_fname = Path:new(fname):absolute()

      if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
        return absolute_cwd
      end

      return lspconfig_util.root_pattern("go.mod", ".git")(fname)
    end,

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

  rust_analyzer = true,
  --   settings = {
  --     ["rust-analyzer"] = {
  --     },
  -- },

  tsserver = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
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

for server, config in pairs(servers) do
  setup_server(server, config)
end

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

-- require("sg.lsp").setup {
--   on_init = custom_init,
--   on_attach = custom_attach,
-- }

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

-- python graveyard
-- lspconfig.pyls.setup {
--   plugins = {
--     pyls_mypy = {
--       enabled = true,
--       live_mode = false
--     }
--   },
--   on_init = custom_init,
--   on_attach = custom_attach,
--   capabilities = updated_capabilities,
-- }

-- lspconfig.jedi_language_server.setup {
--   on_init = custom_init,
--   on_attach = custom_attach,
--   capabilities = updated_capabilities,
-- }

return {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = updated_capabilities,
}
