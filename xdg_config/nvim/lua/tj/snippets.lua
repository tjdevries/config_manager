require('plenary.reload').reload_module("nlua")
require('plenary.reload').reload_module("snippets")

-- TODO: We should check out the UX stuff here. Norcalli made something sweet.
-- require'snippets'.set_ux(require'snippets.inserters.vim_input')

local snip_plug = require('snippets')

local snips = {}

snips._global = {
  ["todo"] = "TODO(tjdevries): ",
  ["date"] = [[${=os.date("%Y-%m-%d")}]],
}

snips.lua = vim.tbl_deep_extend(
  "error",
  require('nlua.snippets.snippets_nvim').get_lua_snippets(),
  {
    -- Custom parsed item, for a plugin I use a lot.
    get_parsed = [[local parsed = get_parsed($1)]],

    reload = [[require('plenary.reload').reload_module('$1')$0]],
  }
)

snip_plug.snippets = snips
snip_plug.use_suggested_mappings()

-- TODO: Investigate this again.
require'snippets'.set_ux(require'snippets.inserters.floaty')

-- Shortcuts for me to edit the snippet files
--  Could possibly use fzf or something for this, but this seemds good for now.
vim.cmd [[nnoremap ,se :e ~/.config/nvim/lua/tj/snippets.lua<CR>]]
vim.cmd [[nnoremap ,sn :e ~/plugins/nlua.nvim/lua/nlua/snippets/snippets_nvim.lua<CR>]]

--[[
-- Leftover from stream
-- function ExampleForMccannch()
--   vim.fn.complete(vim.fn.col('.'), { "hello", "world", "Tj is a nice streamer", "TJ is a helpful streamer" })
--   return ''
-- end
-- vim.cmd [[inoremap <c-x><c-m> <C-R>=v:lua.ExampleForMccannch()<CR>]]
-- vim.cmd [[inoremap <c-x><c-m> <C-R>=luaeval('require("my.plugin").thing()')<CR>]]
--]]
