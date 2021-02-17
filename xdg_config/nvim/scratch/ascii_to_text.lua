local bufnr = 6

for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
  print(string.char(tonumber(line)))
end
