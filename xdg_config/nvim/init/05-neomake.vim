try
    silent call plug#load('neomake')
catch
endtry

if exists('g:neomake_config_done') || !exists(':Neomake')
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
let g:neomake_c_enabled_makers = []
let g:neomake_cpp_enabled_makers = []


" Zsh
" Trying to add shellcheck, but it no longer is supported for zsh :'(
" let g:neomake_zsh_shellcheck_maker = {
"         \ 'args': ['-f json']
"         \ }

" let g:neomake_zsh_enabled_makers = ['shellcheck']

augroup vimrc_neomake
    autocmd!
    autocmd BufWritePost * silent Neomake
    autocmd VimLeave * let g:neomake_verbose = 0
augroup END
