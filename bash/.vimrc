" This ./vimrc expects that vundle is installed.  To install vundle:
"   git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" The Following Pluggins are installed:
"   git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
"   git clone git://github.com/fatih/vim-go.git                     ~/.vim/bundle/vim-go
"   git clone git://github.com/tpope/vim-sleuth.git                 ~/.vim/bundle/vim-sleuth

set nocompatible              " be iMproved, required
filetype off                  " required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, this is required (duh)
Plugin 'gmarik/Vundle.vim'
" Tell Vundle about the others
Plugin 'altercation/vim-colors-solarized'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-sleuth'

" Do not add plugins after this line!
call vundle#end()            " required
filetype plugin indent on    " required

" Add Line Numbers
set number

" Line wrapping options
set wrap
set linebreak
set nolist  " list will disable linebreak
nmap <up> gk
nmap <down> gj

" Tab Kernoodeling
set tabstop=4    " tab is interpreted as 4 spaces (still is \t)
set shiftwidth=4 " indents will have a width of 4
set expandtab    " by default, convert tabs to spaces (a pluggin will guess through)

" Prevent vim from automatically inserting line breaks in entered text
set textwidth=0
set wrapmargin=0

" Pressing ,ss will toggle and untoggle spell checking
nmap <leader>ss :setlocal spell!<cr>

nmap <leader>sn ]s
nmap <leader>sp {s
nmap <leader>sa zg
nmap <leader>s? z=

" Let the mouse move the cursor
set mouse=n

" Enable titles in terminal tabs!
set title

" COLORS!
set t_Co=256

" Syntax Highlighting
syntax enable
let g:solarized_termcolors=256
let g:solarized_termtrans=1
set background=dark
colorscheme solarized

" Enable ctags (Search up parent directories until it finds 'tags')
set tags=tags;

