
set expandtab
set shiftwidth=4
" set 

" {{{ Completion
" setlocal omnifunc=jedi#completions
" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#smart_auto_mappings = 0
" let g:jedi#show_call_signatures = 0
" let g:jedi#force_py_version = 3
" }}}
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
" {{{ Impsort
" autocmd BufWritePre *.py ImpSort!
" }}}
" {{{ Misc
let g:vimpy_remove_unused = 1
" autocmd BufWritePre *.py :%s/\s\+$//e
" }}}

if g:builtin_lsp
  setlocal omnifunc=lsp#omnifunc
endif

" silent! call LoadPyne()

augroup MyPythonAutos
  au!
  autocmd BufWritePost * :call PythonAuto()

  " Only for our special .status.py files
  autocmd BufWritePost * :call nb_sync#sync()
augroup END


nnoremap <buffer> <space><space>x :call nb_sync#execute()<CR>

" nnoremap <buffer> <space>i :lua require('apyrori').insert_match(vim.api.nvim_call_function('expand', {'<cword>'}))<CR>
" nnoremap <buffer> <M-i> :lua require('apyrori').insert_match(vim.api.nvim_call_function('expand', {'<cword>'}))<CR>
