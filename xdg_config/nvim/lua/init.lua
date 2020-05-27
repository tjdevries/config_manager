
-- Load lsp config
local ok, _ = pcall(function() require('lsp_config') end)
if not ok then
  return
end

-- Load required packages
local neorocks = require("plenary.neorocks")

neorocks.setup_hererocks()

neorocks.ensure_installed('penlight', 'pl', true)
neorocks.ensure_installed('lua-cjson', 'cjson', true)

-- Cool highlighting courtesy of @clason
vim.cmd[[augroup LuaHighlight]]
vim.cmd[[  au!]]
vim.cmd[[  au TextYankPost * silent! lua require'vim.highlight'.on_yank()]]
vim.cmd[[augroup END]]
