" Vim specific configuration file

" Plugin Manager
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'vim-autoclose')

execute pathogen#infect()

" Don't worry about old compatibility
set nocompatible


" ----- Color Scheme -----
" The next command does this "set background=dark""
highlight Normal ctermfg=grey ctermbg=black

colorscheme solarized
let g:solarized_termcolors=256

