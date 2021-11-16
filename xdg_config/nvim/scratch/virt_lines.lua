local ns = vim.api.nvim_create_namespace "test:virtlines"

vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

vim.api.nvim_buf_set_extmark(0, ns, 3, 0, {
  virt_lines = { { { "hello", "Error" }, { " hello", "Comment" } } },
  virt_lines_above = false,
  virt_lines_leftcol = true,
})

vim.api.nvim_buf_set_extmark(0, ns, 4, 0, {
  virt_lines = { { { "hello", "Nontext" }, { " hello", "Comment" } } },
  virt_lines_above = true,
  virt_lines_leftcol = false,
})
