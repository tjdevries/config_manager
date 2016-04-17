
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
nmap <C-k> [pf
nmap <C-j> ]pf
" }}}
" {{{ Misc
let g:vimpy_remove_unused = 1
" autocmd BufWritePre *.py :%s/\s\+$//e
" }}}
