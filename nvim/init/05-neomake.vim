if exists('g:neomake_config_done')
    finish
endif

let g:neomake_config_done = 1

nnoremap <leader>m :Neomake<CR>

" Automatically open the error window
let g:neomake_open_list = 1

" Python
let g:neomake_python_flake8_maker = {
        \ 'args': ['--max-line-length=140', '--ignore=E402']
        \ }

" TODO: Get prospector to work, maybe just on a special command.
" let g:neomake_python_prospector_maker = {
"     \ 'exe': 'prospector',
"     \ 'args': ['%:p'],
"     \ }
" let g:neomake_python_enabled_makers = [ 'flake8', 'prospector' ]

let g:neomake_python_enabled_makers = [ 'flake8' ]

" Vim
let g:neomake_vimscript_enabled_makers = [ 'vint' ]

" Javascript
let g:neomake_javascript_jshint_maker = {
    \ 'args': ['--verbose'],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
    \ }
let g:neomake_javascript_enabled_makers = ['jshint']

" C
" let g:neomake_c_gcc_maker = {
" \ }
" let g:neomake_c_enabled_makers = ['clang-3.6']

augroup vimrc_neomake
    autocmd!
    autocmd BufWritePost * silent Neomake
    autocmd VimLeave * let g:neomake_verbose = 0
augroup END
