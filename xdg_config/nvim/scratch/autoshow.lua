local command = vim.cmd

command "autocmd! BufEnter"
command "autocmd BufEnter * :echo 'Hello'"
command [[
  augroup TestingOne
    autocmd BufEnter * :echo "Line 1"
    autocmd BufEnter * :echo "Line 2"
  augroup END
]]

vim.cmd [[autocmd BufEnter]]
