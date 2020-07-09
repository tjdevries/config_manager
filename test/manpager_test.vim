augroup man
  autocmd!
  autocmd BufReadCmd man://* call man#read_page(matchstr(expand('<amatch>'), 'man://\zs.*'))
augroup END

profile start /tmp/nvim_printf.prof
profile func *
call man#open_page(0, 1, '', 'printf')
profile stop

profile start /tmp/nvim_ls.prof
profile func *
call man#open_page(0, 0, '', 'ls')
profile stop

quitall!
