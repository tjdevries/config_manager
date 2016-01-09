" Neovim specific configuration file

" TODO
" Find a way to do color schemes with vim-plug
" Figure out how to use ctrl-p

if has('unix')
    let g:python_host_prog = '/usr/bin/python'
    " let g:python3_host_prog = '/usr/bin/python3'
else
    let g:python_host_pgro = 'C:\python
endif

" Automatically installs vim-plug if not already there
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Extend the length of the timeout for vim-plug
let g:plug_timeout=600

" Plugin management: Vim-plug
"   Choose the correct path
if has('unix')
    let plugin_path = "~/.vim/plugged"
else
    let plugin_path = "C:\neovim\"
endif

call plug#begin(plugin_path)

" Fun status line
Plug 'bling/vim-airline'

" Syntax Type Plugins
" Plug 'scrooloose/syntastic'
" Plug 'klen/python-mode', { 'for': 'python' } " Not sure I like this one
Plug 'benekastah/neomake'       " A better linter than syntastic?

" UltiSnips
Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets'

" Deoplete
Plug 'Shougo/deoplete.nvim'

" YouCompleteMe, not using right now. Went for Deoplete
" Plug 'valloric/youcompleteme', { 'do': './install.py --clang-completer --gocode-completer' }

" Tag Based Plugins
Plug 'majutsushi/tagbar'

" Git Based Plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Text Manipulation Based Plugins
Plug 'godlygeek/tabular'        " Quickly align text by pattern
Plug 'tpope/vim-surround'       " Surround text objects easily
Plug 'tpope/vim-speeddating'    " Handle changing of dates in a nicer manner
Plug 'tpope/vim-commentary'     " Easily comment out lines or objects
Plug 'tpope/vim-repeat'         " Repeat actions better

" Fuzzy file finding
Plug 'junegunn/fzf', { 'do': './install --all'}     " Fuzzy Searcher
Plug 'junegunn/fzf.vim'                             " Fuzzy Search NOW WITH VIM! 

" Markdown Plugins
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" Colorscheme Plugins
Plug 'morhetz/gruvbox'          " gruvbox

" Nyaovim Plugins
Plug 'rhysd/nyaovim-markdown-preview'

call plug#end()

" Nvim automatically turns on preview, which I don't like
set completeopt-=preview

" Make updates happen faster
set updatetime=250

"----- Deoplete -----
let g:deoplete#enable_at_startup = 1

" ----- Neomake -----
" Automatically run Neomake on write
autocmd! BufWritePost *  Neomake

" Automatically open the error window
let g:neomake_open_list = 1

" Python
let g:neomake_python_flake8_maker = {
        \ 'args': ['--max-line-length=120']
        \ }

let g:neomake_python_enabled_makers = [ 'flake8' ]

" Vim
let g:neomake_vimscript_enabled_makers = [ 'vint' ]

" ----- Colorscheme -----
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1   " Turn on better color support in vim
let g:gruvbox_italic=1              " Turn on italics for gruvbox
colorscheme gruvbox

set background=dark

" ----- Nyaovim Markdown Preview Settings -----
" Only apply if it is loaded
" if exists(':StartMarkdownPreview')
let g:markdown_preview_auto = 1
let g:markdown_preview_eager = 1 
" endif
