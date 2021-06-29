vim.api.nvim_set_keymap("n", "<C-a>", "<Plug>(dial-increment)", {
  noremap = false,
  silent = true,
})

vim.api.nvim_set_keymap("n", "<C-x>", "<Plug>(dial-decrement)", {
  noremap = false,
  silent = true,
})
