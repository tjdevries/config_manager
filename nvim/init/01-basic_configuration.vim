" Set our leader key to ,
let g:mapleader=','

" Set important paths
if has('unix')
    let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
    let g:python2_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
    let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
else
    let g:python_host_prog = 'C:\python'
endif

filetype plugin indent on

set wildignore=*.o,*~,*.pyc,*pycache* " Ignore compiled files
set cmdheight=2                       " Height of the command bar
set incsearch                         " Makes search act like search in modern browsers
set showmatch                         " show matching brackets when text indicator is over them
set relativenumber                    " Show line numbers
set number                            " But show the actual number for the line we're on
set ignorecase                        " Ignore case when searching...
set smartcase                         " ... unless there is a capital letter in the query

set completeopt+=preview              " Turn On preview
set splitright                        " Prefer windows splitting to the right
set splitbelow                        " Prefer windows splitting to the bottom
set updatetime=250                    " Make updates happen faster
set nohlsearch

set scrolloff=10                      " Make it so there are always ten lines below my cursor

" Tabs
" Want auto indents automatically
set autoindent
set cindent
set wrap

" Set the width of the tab to 4 wid
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround

" Make it so that long lines wrap smartly
set breakindent
let &showbreak=repeat(' ', 3)
set linebreak

" Always use spaces instead of tab characters
set expandtab

" Folding
set foldmethod=marker
set foldlevel=0
set modelines=1

" Clipboard
set clipboard+=unnamedplus
