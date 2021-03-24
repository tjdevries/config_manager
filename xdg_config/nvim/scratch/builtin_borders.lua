
local bufnr = vim.api.nvim_create_buf(false, true)
local win_id = vim.api.nvim_open_win(bufnr, true, {
  relative = 'editor',
  row = 10,
  col = 10,
  width = 100,
  height = 25,
  border = "double",
  style = "minimal",
})
