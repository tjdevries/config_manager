" Neovim specific configuration file

" TODO
" Find a way to do color schemes with vim-plug
" Figure out how to use ctrl-p

let g:python_host_prog = '/usr/bin/python'
" let g:python3_host_prog = '/usr/bin/python3'

" Automatically installs vim-plug if not already there
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Extend the length of the timeout for vim-plug
let g:plug_timeout=600

" Plugin management: Vim-plug
call plug#begin('~/.vim/plugged')

" Fun status line
Plug 'bling/vim-airline'

" Syntastic
Plug 'scrooloose/syntastic'

" UltiSnips
Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets'

" YouCompleteMe
Plug 'valloric/youcompleteme', { 'do': './install.py --clang-completer --gocode-completer' }

" Tag Based Plugins
Plug 'majutsushi/tagbar'

" Git Based Plugins
Plug 'tpope/vim-fugitive'

" Text Manipulation Based Plugins
Plug 'godlygeek/tabular'        " Quickly align text by pattern
Plug 'tpope/vim-surround'       " Surround text objects easily
Plug 'tpope/vim-speeddating'    " Handle changing of dates in a nicer manner
Plug 'tpope/vim-commentary'     " Easily comment out lines or objects
Plug 'tpope/vim-repeat'         " Repeat actions better

" Markdown Plugins
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

call plug#end()

" Nvim automatically turns on preview, which I don't like
set completeopt-=preview

" ----- Colorscheme -----
colorscheme slate
