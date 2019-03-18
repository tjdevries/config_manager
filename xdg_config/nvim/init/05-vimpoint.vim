
augroup MyVimpoint
  au!
  autocmd BufEnter,BufRead *.vpf setlocal listchars=
  autocmd BufEnter,BufRead *.vpf setlocal nonumber
  autocmd BufEnter,BufRead *.vpf setlocal norelativenumber
augroup END
