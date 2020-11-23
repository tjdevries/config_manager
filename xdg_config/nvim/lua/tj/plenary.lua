
function PlenaryTestFile()
  local filename = vim.fn.expand("%:p")

  RELOAD('plenary')
  require('plenary.test_harness'):test_directory('busted', filename)
end

vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua PlenaryTestFile()<CR>", { noremap = true })
