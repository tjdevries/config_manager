local vim = vim
local nvim_lsp = require('nvim_lsp')


vim.fn.nvim_set_var('diagnostic_enable_virtual_text', 1)
vim.fn.nvim_set_var('diagnostic_insert_delay', 1)

local custom_attach = function(...)
    require('diagnostic').on_attach(...)
    require('completion').on_attach(...)

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

nvim_lsp.vimls.setup({})


local sumneko_settings = {
    runtime={
        version="LuaJIT",
    },
    diagnostics={
        enable=true,
        globals={"vim"},
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
    on_attach=custom_attach
})

nvim_lsp.clangd.setup({
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
--
