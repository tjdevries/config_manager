
local vim = vim
local nvim_lsp = require('nvim_lsp')

-- vim.lsp.set_log_level(0)

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


local sumneko_settings = {
    runtime={
        version="LuaJIT",
    },
    diagnostics={
        enable=true,
        globals={"vim"},
    }
}

-- nvim-lsp overrides workspace/configuration callback
--  and makes it difficult to set any other way than this.
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
    }
})


nvim_lsp.tsserver.setup({
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
