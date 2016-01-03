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

" UI Improvements
Plug 'bling/vim-airline'
Plug 'haya14busa/vim-operator-flashy' | Plug 'kana/vim-operator-user'

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
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'

" Markdown Plugins
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

call plug#end()

" Nvim automatically turns on preview, which I don't like
set completeopt-=preview

" ----- Flashy Operator -----
" Make it auto trigger on yank
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

" ----- Colorscheme -----
colorscheme slate
