

local vim = vim
local nvim_lsp = require'nvim_lsp'

nvim_lsp.pyls.setup({
    enable=true,
    plugins={
        pyls_mypy={
            enabled=true,
            live_mode=false
        }
    }
})

nvim_lsp.vimls.setup({})

nvim_lsp.sumneko_lua.setup({
    filetypes = {"lua"},
    cmd = {
        "/home/tj/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/Linux/lua-language-server",
        "-E",
        "/home/tj/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua"
    }
})


-- Override some callbacks for my personal preference
local override = require("custom.lsp_override").override

override("textDocument/publishDiagnostics", require("custom.diagnostics").handle_diagnostics)

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
