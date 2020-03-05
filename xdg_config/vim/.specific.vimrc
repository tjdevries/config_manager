" Vim specific configuration file

" Plugin Manager
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'vim-autoclose')

execute pathogen#infect()

" Don't worry about old compatibility
set nocompatible

" ----- Syntastic Things -----
"  Really not sure what these things do yet
"  For now going to use flake8 instead of syntastic.
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wg = 0

" Allowing Checkers
let g:synastic_python_checkers = ['flake8']

" ----- Color Scheme -----
" The next command does this "set background=dark""
highlight Normal ctermfg=grey ctermbg=black

colorscheme solarized
let g:solarized_termcolors=256

