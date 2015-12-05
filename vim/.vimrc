" ----- Things to pursue further -----
" completeopt=??
" For regular expressions turn magic on
" set magic

" Plugin Manager
execute pathogen#infect()

" Don't worry about old compatibility
set nocompatible

" ----- Vim User Interface -----
" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Height of the command bar
set cmdheight=2

" Makes search act like search in modern browsers
set incsearch

" show matching brackets when text indicator is over them
set showmatch

" Show line numbers
set number

" Load filetype-specific indent files
" Also enables plugins?
filetype plugin indent on

" Useability
" Enable smart autocompletion for programs
set omnifunc=syntaxcomplete#Complete

" Spell check
set spell

" Make it so there are always ten lines below my cursor
set scrolloff=10

" ----- Tab things -----
" Want auto indents automatically
set autoindent
set cindent
set wrap

" Set the width of the tab to 4 wid
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Make it so that long lines wrap smartly
set breakindent
let &showbreak=repeat(' ', 3)
set linebreak

" Always use spaces instead of tab characters
set expandtab

" ----- Syntastic Things -----
"  Really not sure what these things do yet
"  For now going to use flake8 instead of syntastic.
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wg = 0

" Allowing Checkers
let g:synastic_python_checkers = ['flake8']

" ----- Airline Things -----
" Pretty fonts!
" let g:airline_powerline_fonts = 1

" Some default settings that modify the statusline
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"  Sets the python checker to look for Python 3
let g:syntastic_python_python_exec = '/usr/bin/python3'

" ----- CtrlP Things -----
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'

" ----- ctags -----
" Enable ctags
set tags=tags;

" ----- Markdown Things -----
augroup markdown
    " remove buffer-local auto commands forcurrent buffer
    au!
    " hook to run TableFormat when <bar> is entered in insert mode
    au FileType mkd.markdown exec 'inoremap \| \|<C-O>:TableFormat<CR><C-O>f\|<right>'
    " Ctrl+\ will run TableFormat in either mode
    au FileType mkd.markdown exec 'inoremap <C-\> <C-O>:TableFormat<CR>'
    au FileType mkd.markdown exec 'noremap <silent> <C-\> :TableFormat<CR>'

    let g:vim_markdown_folding_disabled=1
augroup END


" ----- Color Things -----
" Enable syntax highlighting
syntax enable
syntax on

" Choose Color scheme
" The next command does this "set background=dark""
highlight Normal ctermfg=grey ctermbg=black
colorscheme solarized

let g:solarized_termcolors=256

" ------------------------- Old Items: Kept for Reference -------------------------   
" ----- Flake8 Things -----
" Run flake8() whenever a python file is written
" autocmd BufWritePost *.py call Flake8()
" Trying to do this using syntastic now. Refer above

" ----- Status Line (Python) -----
" This currently doesn't work
" python from powerline.vim import setup as powerline_setup
" python powerline_setup()
" python del powerline_setup

