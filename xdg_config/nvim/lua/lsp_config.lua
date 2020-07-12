local nvim_lsp = require('nvim_lsp')
local nvim_status = require('lsp-status')
local completion = require('completion')

local status = require('tj.status')

-- Can set this lower if needed.
-- require('vim.lsp.log').set_level("debug")
-- require('vim.lsp.log').set_level("trace")

Diagnostic = vim.lsp.actions.Diagnostic
Location = vim.lsp.actions.Location

-- Turn on status.
status.activate()

vim.lsp.callbacks["textDocument/publishDiagnostics"] = Diagnostic.handle_publish_diagnostics.with {
  should_underline = false,
  update_in_insert = false
}

local custom_attach = function(client)
  completion.on_attach(client)
  status    .on_attach(client)

  local mapper = function(mode, key, result)
    vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap=true, silent=true})
  end

  mapper('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  mapper('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
  mapper('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  mapper('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  mapper('n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  mapper('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')

  mapper('n', '<space>sl', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')

  -- TODO: Decide if these are good.
  mapper('n', '<space>pd', ':PrevDiagnostic<CR>')
  mapper('n', '<space>nd', ':NextDiagnostic<CR>')

  mapper(
    'n',
    '<space>gd',
    '<cmd>lua vim.lsp.buf.definition { callbacks = { Location.jump_first, Location.highlight.with { timeout = 300 } } }<CR>'
  )

  mapper(
    'n',
    '<space>pd',
    '<cmd>lua vim.lsp.buf.definition { callbacks = Location.preview.with { lines_below = 5 } }<CR>'
  )

  mapper(
    'n',
    '<leader>dn',
    '<cmd>lua vim.lsp.structures.Diagnostic.buf_move_next_diagnostic()<CR>'
  )

  mapper(
    'n',
    '<leader>dp',
    '<cmd>lua vim.lsp.structures.Diagnostic.buf_move_prev_diagnostic()<CR>'
  )


  mapper('i', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  -- Not sure if this is right
  vim.cmd("setlocal omnifunc=v:lua.vim.lsp.omnifunc")
end

nvim_lsp.pyls.setup({
  enable=true,
  plugins={
    pyls_mypy={
      enabled=true,
      live_mode=false
    }
  },
  on_attach=custom_attach
})

nvim_lsp.vimls.setup({
  on_attach = custom_attach,
})


local sumneko_settings = {
  runtime={
    version="LuaJIT",
  },
  diagnostics={
    enable=true,
    globals={
      "vim", "Color", "c", "Group", "g", "s", "describe", "it", "before_each", "after_each"
    },
  },
}
sumneko_settings.Lua = vim.deepcopy(sumneko_settings)

nvim_lsp.sumneko_lua.setup({
  -- Lua LSP configuration
  settings=sumneko_settings,

  -- Runtime configurations
  filetypes = {"lua"},
  cmd = {
    "/home/tj/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/Linux/lua-language-server",
    "-E",
    "/home/tj/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua"
  },

  on_attach=custom_attach
})

nvim_lsp.tsserver.setup({
  cmd = {"typescript-language-server", "--stdio"},
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx"
  },
  on_attach=custom_attach
})

nvim_lsp.clangd.setup({
  cmd = {"clangd", "--background-index"},
  on_attach = custom_attach,

  -- Required for lsp-status
  init_options = {
    clangdFileStatus = true
  },
  callbacks = nvim_status.extensions.clangd.setup(),
  capabilities = nvim_status.capabilities,
})

nvim_lsp.rust_analyzer.setup({
  cmd = {"rust-analyzer"},
  filetypes = {"rust"},
  on_attach = custom_attach,
})

vim.g.indicator_errors = ''
vim.g.indicator_warnings = ''
vim.g.indicator_info = '🛈'
vim.g.indicator_hint = '!'
vim.g.indicator_ok = ''
vim.g.spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'}

--[[
Example settings, have not messed around with too many of these.
-- require 'nvim_lsp'.pyls_ms.setup{
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

