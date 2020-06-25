
-- Load lsp config
local ok, _ = pcall(function() require('lsp_config') end)
if not ok then
  return
end

-- Load required packages
local neorocks = require("plenary.neorocks")

-- Run the first time to install it
if false then
  neorocks.install('penlight', 'pl')
  neorocks.install('luasocket', 'socket')
end

neorocks.ensure_installed('penlight', 'pl')
neorocks.ensure_installed('lua-cjson', 'cjson')
neorocks.ensure_installed('luasocket', 'socket')
neorocks.ensure_installed('moses', 'moses')

-- Cool highlighting courtesy of @clason
vim.cmd[[augroup LuaHighlight]]
vim.cmd[[  au!]]
vim.cmd[[  au TextYankPost * silent! lua require'vim.highlight'.on_yank()]]
vim.cmd[[augroup END]]
