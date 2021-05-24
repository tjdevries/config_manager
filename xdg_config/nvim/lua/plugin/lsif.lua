local nnoremap = vim.keymap.nnoremap
local Path = require "plenary.path"

local lsif = {}

lsif.position = function()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row = cursor_pos[1]
  local col = cursor_pos[2]

  local filename = Path:new(vim.api.nvim_buf_get_name(0)):make_relative()

  vim.fn.setreg("+", string.format([[{
  "textDocument": "%s",
  "position": {
    "line": %s, "character": %s
  }
}]], filename, row - 1, col))
end

lsif.range = function()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row = cursor_pos[1]
  local col = cursor_pos[2]

  local start = vim.fn.getpos "'<"
  local finish = vim.fn.getpos "'>"

  local filename = "file://" .. Path:new(vim.api.nvim_buf_get_name(0)):make_relative()

  vim.fn.setreg("+", string.format([[
    {
      "uri": "%s",
      "range": {
        "start": { "line": %s, "character": %s },
        "end": {"line": %s, "character": %s }
      }
    }
  ]], filename, start[2] - 1, start[3] - 1, finish[2] - 1, finish[3] - 1))
end

LsifRange = lsif.range

nnoremap { "<space>lp", lsif.position }

vim.api.nvim_set_keymap("v", "<space>lr", ":'<,'>lua LsifRange()<CR>", { noremap = true })

return lsif
