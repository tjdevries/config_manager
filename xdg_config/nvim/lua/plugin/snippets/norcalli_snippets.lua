R "nlua"

-- TODO: We should check out the UX stuff here. Norcalli made something sweet.
-- require'snippets'.set_ux(require'snippets.inserters.vim_input')

local ok = pcall(require, "snippets")
if not ok then
  return
end

local indent = require("snippets.utils").match_indentation

local snip_plug = R "snippets"

local snips = {}

snips._global = {
  ["todo"] = "TODO(tjdevries): ",
  ["date"] = [[${=os.date("%Y-%m-%d")}]],
  ["rs"] = [[${=RandomString(25)}]],
}

snips.lua = vim.tbl_deep_extend("error", require("nlua.snippets").get_lua_snippets(), {
  -- Custom parsed item, for a plugin I use a lot.
  get_parsed = [[local parsed = get_parsed($1)]],

  reload = [[require('plenary.reload').reload_module('$1')$0]],
})

snips.json = {
  testEntry = [[, {"text": "$1"}]],
  i = [["$1": "$2"]],
  e = [[, {"text": "$1: ${=RandomString(25)}", "score": $1}]],
}

snips.rust = {}

snips.rust.mod_test = indent [[
#[cfg(test)]
mod tests {
  use super::*;

  $0
}
]]

snips.rust.test = indent [[
#[test]
fn $1() {
  $0
}]]

snips.go = R "tj.snips.go"
snips.python = R "tj.snips.python"

snip_plug.snippets = snips
snip_plug.use_suggested_mappings()

-- TODO: Investigate this again.
require("snippets").set_ux(require "snippets.inserters.floaty")

-- Shortcuts for me to edit the snippet files
--  Could possibly use fzf or something for this, but this seemds good for now.
vim.cmd [[nnoremap ,se :e ~/.config/nvim/lua/tj/snippets.lua<CR>]]
vim.cmd [[nnoremap ,sn :e ~/plugins/nlua.nvim/lua/nlua/snippets.lua<CR>]]

local charset = {}
do -- [0-9a-zA-Z]
  -- for c = 48, 57  do table.insert(charset, string.char(c)) end
  for c = 65, 90 do
    table.insert(charset, string.char(c))
  end
  for c = 97, 122 do
    table.insert(charset, string.char(c))
  end
  table.insert(charset, " ")
  table.insert(charset, " ")
  table.insert(charset, " ")
  table.insert(charset, " ")
  table.insert(charset, " ")
  table.insert(charset, " ")
end

function RandomString(length)
  if not length or length <= 0 then
    return ""
  end
  math.randomseed(os.clock() ^ 5)
  return RandomString(length - 1) .. charset[math.random(1, #charset)]
end

--[[
-- Leftover from stream
-- function ExampleForMccannch()
--   vim.fn.complete(vim.fn.col('.'), { "hello", "world", "Tj is a nice streamer", "TJ is a helpful streamer" })
--   return ''
-- end
-- vim.cmd [[inoremap <c-x><c-m> <C-R>=v:lua.ExampleForMccannch()<CR>]]
-- vim.cmd [[inoremap <c-x><c-m> <C-R>=luaeval('require("my.plugin").thing()')<CR>]]
--]]
