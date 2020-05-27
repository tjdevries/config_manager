local nvim_lsp = require('nvim_lsp')
local lsp_status = require('lsp-status')

require('vim.lsp.log').set_level("trace")

vim.g.diagnostic_enable_virtual_text = 1
vim.g.diagnostic_insert_delay = 1

lsp_status.config {
  select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ["start"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[1])
        },
        ["end"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[2])
        }
      }

      return require("lsp-status.util").in_range(cursor_pos, value_range)
    end
  end
}

local do_progress = false
local setup_progress = function(client)
  if do_progress then
    lsp_status.register_progress()

    -- Register the client for messages
    lsp_status.register_client(client.name)
  end

  -- Set up autocommands for refreshing the statusline when LSP information changes
  vim.api.nvim_command('augroup lsp_aucmds')
  vim.api.nvim_command('  au! * <buffer>')
  if do_progress then
    vim.api.nvim_command('  au User LspDiagnosticsChanged redrawstatus!')
    vim.api.nvim_command('  au User LspMessageUpdate      redrawstatus!')
    vim.api.nvim_command('  au User LspStatusUpdate       redrawstatus!')
  end
  vim.api.nvim_command('augroup END')

  -- If the client is a documentSymbolProvider, set up an autocommand to update the containing function
  if client.resolved_capabilities.document_symbol then
    vim.api.nvim_command('augroup lsp_aucmds')
    vim.api.nvim_command('  au CursorHold,BufEnter <buffer> lua require("lsp-status").update_current_function()')
    vim.api.nvim_command('augroup END')
  end
end

local custom_attach = function(client)
  require('completion').on_attach(client)
  require('diagnostic').on_attach(client)

  local mapper = function(mode, key, result)
    vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap=true, silent=true})
  end

  mapper('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  mapper('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
  mapper('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  mapper('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  mapper('n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  mapper('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')

  mapper('i', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  -- Not sure if this is right
  vim.cmd("setlocal omnifunc=lsp#omnifunc")

  setup_progress(client)
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
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  on_attach=custom_attach
})

nvim_lsp.clangd.setup({
  cmd = {"clangd", "--background-index"},
  on_attach=custom_attach
})


--1
if false then
  -- Override some callbacks for my personal preference
  local override = require("custom.lsp_override").override

  -- I want to test out haorenW1025/diagnostic-nvim first
  override("textDocument/publishDiagnostics", require("custom.diagnostics").handle_diagnostics)

  _ = [[
  " Helpful overrides for diagnostics

  " [D]iagnostics [E]nable
  nnoremap <silent> <space>de <cmd>lua require("custom.diagnostics").set_diagnostic_display(true)<CR>
  " [D]iagnostics [D]isable
  nnoremap <silent> <space>dd <cmd>lua require("custom.diagnostics").set_diagnostic_display(false)<CR>

  " [D]iagnostics [C]ustom
  nnoremap <silent> <space>dc <cmd>lua require("custom.diagnostics").use_custom(nil)<CR>
  ]]
end

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

_ = [[
Example settings, have not messed around with too many of these.
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
            ]]

vim.g.indicator_errors = ''
vim.g.indicator_warnings = ''
vim.g.indicator_info = '🛈'
vim.g.indicator_hint = '❗'
vim.g.indicator_ok = ''
vim.g.spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'}

vim.g.should_show_diagnostics_in_statusline = false

function StatusLineLSP()
  if #vim.lsp.buf_get_clients() == 0 then
    return ''
  end

  local status_parts = {}
  local base_status = ''

  local some_diagnostics = false
  local only_hint = true

  if vim.g.should_show_diagnostics_in_statusline then
    local diagnostics = lsp_status.diagnostics()
    local buf_messages = lsp_status.messages()
    if diagnostics.errors and diagnostics.errors > 0 then
      table.insert(status_parts, vim.g.indicator_errors .. ' ' .. diagnostics.errors)
      only_hint = false
      some_diagnostics = true
    end

    if diagnostics.warnings and diagnostics.warnings > 0 then
      table.insert(status_parts, vim.g.indicator_warnings .. ' ' .. diagnostics.warnings)
      only_hint = false
      some_diagnostics = true
    end

    if diagnostics.info and diagnostics.info > 0 then
      table.insert(status_parts, vim.g.indicator_info .. ' ' .. diagnostics.info)
      only_hint = false
      some_diagnostics = true
    end

    if diagnostics.hints and diagnostics.hints > 0 then
      table.insert(status_parts, vim.g.indicator_hint .. ' ' .. diagnostics.hints)
      some_diagnostics = true
    end

    local msgs = {}
    for _, msg in ipairs(buf_messages) do
      local name = aliases[msg.name] or msg.name
      local client_name = '[' .. name .. ']'
      if msg.progress then
        local contents = msg.title
        if msg.message then
          contents = contents .. ' ' .. msg.message
        end

        if msg.percentage then
          contents = contents .. ' (' .. msg.percentage .. ')'
        end

        if msg.spinner then
          contents = vim.g.spinner_frames[(msg.spinner % #vim.g.spinner_frames) + 1] .. ' ' .. contents
        end

        table.insert(msgs, client_name .. ' ' .. contents)
      else
        table.insert(msgs, client_name .. ' ' .. msg.content)
      end
    end

    base_status = vim.trim(table.concat(status_parts, ' ') .. ' ' .. table.concat(msgs, ' '))
  end

  local symbol = ' 🇻' .. ((some_diagnostics and only_hint) and '' or ' ')
  local current_function = vim.b.lsp_current_function
  if current_function and current_function ~= '' then
    symbol = symbol .. '(' .. current_function .. ') '
  end

  if base_status ~= '' then
    return symbol .. base_status .. ' '
  end

  return symbol .. vim.g.indicator_ok .. ' '
end
