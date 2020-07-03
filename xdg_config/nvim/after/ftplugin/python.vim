
set expandtab
set shiftwidth=4

" {{{ Mappings
" CTRL K moves to the function definition above
" CTRL J moves to the function definition below
nmap <leader>k [pf
nmap <leader>j ]pf

nnoremap <silent><leader>df <Esc>:Pytest file<CR>
nnoremap <silent><leader>dc <Esc>:Pytest class<CR>
nnoremap <silent><leader>dm <Esc>:Pytest method<CR>
nnoremap <silent><leader>ds <Esc>:Pytest session<CR>
" }}}

augroup MyPythonAutos
  au!
  autocmd BufWritePost * :call PythonAuto()

  " Only for our special .status.py files
  autocmd BufWritePost * :call nb_sync#sync()
augroup END


nnoremap <buffer> <space><space>x :call nb_sync#execute()<CR>
