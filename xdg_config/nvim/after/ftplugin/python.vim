
set expandtab
set shiftwidth=4

" {{{ Mappings
" CTRL K moves to the function definition above
" CTRL J moves to the function definition below
nmap <leader>k [pf
nmap <leader>j ]pf

nnoremap <buffer><silent> <space>pf <cmd>Pytest file<CR>
nnoremap <buffer><silent> <space>pc <cmd>Pytest function<CR>
nnoremap <buffer><silent> <space>pm <cmd>Pytest method<CR>
nnoremap <buffer><silent> <space>ps <cmd>Pytest session<CR>
" }}}

augroup MyPythonAutos
  au!
  autocmd BufWritePost * :call PythonAuto()
augroup END
