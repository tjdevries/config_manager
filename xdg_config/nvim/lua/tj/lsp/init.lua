local Path = require('plenary.path')

local has_lsp, lspconfig = pcall(require, 'lspconfig')
local _, lspconfig_util = pcall(require, 'lspconfig.util')
if not has_lsp then
  return
end

local nvim_status = require('lsp-status')

local telescope_mapper = require('tj.telescope.mappings')

-- TODO: Consider using this. I do kind of like it :)
local nnoremap = vim.keymap.nnoremap

-- Can set this lower if needed.
require('vim.lsp.log').set_level("debug")
-- require('vim.lsp.log').set_level("trace")

_ = require('lspkind').init()

require('tj.lsp.status').activate()
require('tj.lsp.handlers')

local mapper = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
end

local nvim_exec = function(txt)
  vim.api.nvim_exec(txt, false)
end

-- Turn on status.
-- status.activate()


local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local custom_attach = function(client)
  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

  nvim_status.on_attach(client)

  nnoremap { "<space>dn", vim.lsp.diagnostic.goto_next, buffer = 0 }
  nnoremap { "<space>dp", vim.lsp.diagnostic.goto_prev, buffer = 0 }
  nnoremap { "<space>sl", vim.lsp.diagnostic.show_line_diagnostics, buffer = 0 }

  nnoremap { "gd", vim.lsp.buf.definition, buffer = 0 }
  nnoremap { "gD", vim.lsp.buf.declaration, buffer = 0 }

  nnoremap { "<space>cr", MyLspRename, buffer = 0 }

  telescope_mapper('gr', 'lsp_references', {
    layout_strategy = "vertical",
    sorting_strategy = "ascending",
    prompt_position = "top",
    ignore_filename = true,
  }, true)

  -- TODO: I don't like these combos
  telescope_mapper('<space>wd', 'lsp_document_symbols', { ignore_filename = true }, true)
  telescope_mapper('<space>ww', 'lsp_workspace_symbols', { ignore_filename = true }, true)
  if filetype == 'rust' then
    telescope_mapper('<space>wf', 'lsp_workspace_symbols', {
      ignore_filename = true,
      query = '#',
    }, true)
  end

  telescope_mapper('<space>ca', 'lsp_code_actions', nil, true)

  -- mapper('n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  -- mapper('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  -- mapper('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>')

  if filetype ~= 'lua' then
    mapper('n', 'K', 'vim.lsp.buf.hover()')
  end

  mapper('i', '<c-s>', 'vim.lsp.buf.signature_help()')
  mapper('n', '<space>rr', 'vim.lsp.stop_client(vim.lsp.get_active_clients()); vim.cmd [[e]]')

  -- Rust is currently the only thing w/ inlay hints
  if filetype == 'rust' then
    vim.cmd(
      [[autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { ]]
        .. [[aligned = true, prefix = " » " ]]
      .. [[} ]]
    )
  end

  if vim.tbl_contains({"go", "rust"}, filetype) then
    vim.cmd [[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()]]
  end

  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    nvim_exec [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.codeLens = {
  dynamicRegistration = false,
}
updated_capabilities = vim.tbl_deep_extend('keep', updated_capabilities, nvim_status.capabilities)
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
updated_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}


lspconfig.yamlls.setup {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = updated_capabilities,
}

lspconfig.pyls.setup {
  plugins = {
    pyls_mypy = {
      enabled = true,
      live_mode = false
    }
  },
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = updated_capabilities,
}

lspconfig.vimls.setup {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = updated_capabilities,
}

GoRootDir = function(fname)
  local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
  local absolute_fname = Path:new(fname):absolute()

  if string.find(absolute_cwd, "/cmd/", 1, true)
      and string.find(absolute_fname, absolute_cwd, 1, true) then
    return absolute_cwd
  end

  return lspconfig_util.root_pattern("go.mod", ".git")(fname)
end

lspconfig.gopls.setup {
  on_init = custom_init,
  on_attach = custom_attach,

  capabilities = updated_capabilities,
  root_dir = GoRootDir,

  settings = {
    gopls = {
      codelenses = { test = true },
    }
  },
}

lspconfig.gdscript.setup {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = updated_capabilities,
}

-- Load lua configuration from nlua.
require('nlua.lsp.nvim').setup(lspconfig, {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = updated_capabilities,

  root_dir = function(fname)
    if string.find(vim.fn.fnamemodify(fname, ":p"), "xdg_config/nvim/") then
      return vim.fn.expand("~/git/config_manager/xdg_config/nvim/")
    end

    -- ~/git/config_manager/xdg_config/nvim/...
    return lspconfig_util.find_git_ancestor(fname)
      or lspconfig_util.path.dirname(fname)
  end,

  globals = {
    -- Colorbuddy
    "Color", "c", "Group", "g", "s",

    -- Custom
    "RELOAD",
  }
})

if true then
  lspconfig.tsserver.setup({
    cmd = {"typescript-language-server", "--stdio"},
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx"
    },
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
  })
else
  lspconfig.sourcegraph_ts.setup {
    on_attach = custom_attach
  }
end


lspconfig.clangd.setup({
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
  on_init = custom_init,
  on_attach = custom_attach,

  -- Required for lsp-status
  init_options = {
    clangdFileStatus = true
  },
  handlers = nvim_status.extensions.clangd.setup(),
  capabilities = updated_capabilities,
})

if 1 == vim.fn.executable('cmake-language-server') then
  lspconfig.cmake.setup {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = nvim_status.capabilities,
  }
end

lspconfig.rust_analyzer.setup({
  cmd = {"rust-analyzer"},
  filetypes = {"rust"},
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = nvim_status.capabilities,
})

--[[
Example settings, have not messed around with too many of these.
-- require 'lspconfig'.pyls_ms.setup{
--     init_options = {
--         interpreter = {
--             properties = {
--                 InterpreterPath = "~/.pyenv/versions/sourceress/bin/python",
--                 Version = "3.6"
--             }
--         }
--     }
-- }
let settings = {
\   "pyls" : {
\     "enable" : v:true,
\     "trace" : { "server" : "verbose", },
\     "commandPath" : "",
\     "configurationSources" : [ "pycodestyle" ],
\     "plugins" : {
\       "jedi_completion" : { "enabled" : v:true, },
\       "jedi_hover" : { "enabled" : v:true, },
\       "jedi_references" : { "enabled" : v:true, },
\       "jedi_signature_help" : { "enabled" : v:true, },
\       "jedi_symbols" : {
\         "enabled" : v:true,
\         "all_scopes" : v:true,
\       },
\       "mccabe" : {
\         "enabled" : v:true,
\         "threshold" : 15,
\       },
\       "preload" : { "enabled" : v:true, },
\       "pycodestyle" : { "enabled" : v:true, },
\       "pydocstyle" : {
\         "enabled" : v:false,
\         "match" : "(?!test_).*\\.py",
\         "matchDir" : "[^\\.].*",
\       },
\       "pyflakes" : { "enabled" : v:true, },
\       "rope_completion" : { "enabled" : v:true, },
\       "yapf" : { "enabled" : v:true, },
\     }}}
--]]

local sign_decider
if true then
  sign_decider = function(bufnr)
    local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
    -- No buffer local variable set, so just enable by default
    if not ok then
      return true
    end

    return result
  end
else
  -- LOL, alternate signs.
  sign_decider = coroutine.wrap(function()
    while true do
      coroutine.yield(true)
      coroutine.yield(false)
    end
  end)
end

--[[
0. nil -> do default (could be enabled or disabled)
1. false -> disable it
2. true -> enable, use defaults
3. table -> enable, with (some) overrides
4. function -> can return any of above
--]]

--[ An example of using functions...
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
