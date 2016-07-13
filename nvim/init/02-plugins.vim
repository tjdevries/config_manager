if exists('g:_did_vimrc_plugins')
    finish
endif

let g:_did_vimrc_plugins = 1

" Extend the length of the timeout for vim-plug
let g:plug_timeout=600

" Configure which plugins to use
let g:my_snippet_manager = 'ultisnips'
let g:my_tags_manager = 'gutentags'
let g:my_current_scheme = 'gruvbox-tj'

" Plugin management: Vim-plug
call plug#begin(g:plugin_path)
" To Learn:
" Plug 'tweekmonster/braceless.vim'
Plug 'tweekmonster/colorpal.vim'

" Startup
Plug 'mhinz/vim-startify'

" Testing
Plug 'janko-m/vim-test'
Plug 'junegunn/vader.vim'
" Plug 'TheZoq2/neovim-auto-autoread'     " Autoread files in neovim, use AutoreadLoop
" Plug 'tjdevries/vim-vertex'  "Hopefully soon, this will be pulling from Git :D

" Fun status line
Plug 'bling/vim-airline'
Plug 'mkitt/tabline.vim'

" Syntax Type Plugins
" Plug 'scrooloose/syntastic'
" Plug 'klen/python-mode', { 'for': 'python' } " Not sure I like this one
Plug 'benekastah/neomake'       " A better linter than syntastic?
Plug 'alfredodeza/pytest.vim'   " Pytest helper

" Snippets
if g:my_snippet_manager ==? 'ultisnips'
    Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets'
elseif g:my_snippet_manager ==? 'neosnippet'
    Plug 'Shougo/neosnippet.vim' | Plug 'Shougo/neosnippet-snippets' | Plug 'honza/vim-snippets'
endif

" {{{2 Shougo
" Unite
Plug 'Shougo/unite.vim'
Plug 'Shougo/neoyank.vim'       " Yank ring for unit

" Deoplete  {{{
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neoinclude.vim'

" Plug 'xolox/vim-lua-ftplugin', { 'for': 'lua' }
Plug 'davidhalter/jedi-vim',  {  'for': 'python' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }  " Python
Plug 'Shougo/neco-vim'                           " Vim completion
" Plug 'ervandew/supertab',     {  'for': 'python' }
" Plug 'dbsr/vimpy', { 'for': 'python' ]
" }}}
" }}}

" Web Development
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'vim-scripts/JavaScript-Indent',  { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'html', 'htmldjango'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'html', 'htmldjango'] }

" YouCompleteMe, not using right now. Went for Deoplete
" Plug 'valloric/youcompleteme', { 'do': './install.py --clang-completer --gocode-completer' }

" Tag Based Plugins
if g:my_tags_manager ==? 'gutentags'
    Plug 'ludovicchabant/vim-gutentags'
elseif g:my_tags_manager ==? 'vim-tags'
    Plug 'szw/vim-tags'
elseif g:my_tags_manager ==? 'easytags'
    Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
endif
Plug 'majutsushi/tagbar'

" Git Based Plugins
Plug 'tpope/vim-fugitive'
Plug 'moznion/github-commit-comment.vim'
" Plug 'airblade/vim-gitgutter' " I've been having some problems with this one lately.

" Text Manipulation Based Plugins
Plug 'godlygeek/tabular'        " Quickly align text by pattern
Plug 'tpope/vim-surround'       " Surround text objects easily
Plug 'tpope/vim-speeddating'    " Handle changing of dates in a nicer manner
Plug 'tpope/vim-commentary'     " Easily comment out lines or objects
Plug 'tpope/vim-repeat'         " Repeat actions better
Plug 'tpope/vim-abolish'        " Cool things with words!
Plug 'kana/vim-textobj-user' | Plug 'bps/vim-textobj-python', { 'for': 'python' }
Plug 'vim-pandoc/vim-markdownfootnotes'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'tpope/vim-characterize'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tweekmonster/impsort.vim', {'for': 'python'}

Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }     " Get python alignment to work correctly

" Fuzzy file finding
" Plug 'junegunn/fzf', { 'do': './install --all'}     " Fuzzy Searcher
" Plug 'junegunn/fzf.vim'                             " Fuzzy Search NOW WITH VIM!

" Markdown Plugins
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" Colorscheme and appearance
Plug 'morhetz/gruvbox'                                            " gruvbox
Plug 'tjdevries/gruvbox-tj/'                                      " my gruvbox!
Plug 'junegunn/seoul256.vim'                                      " seoul color scheme
Plug 'junegunn/goyo.vim'                                          " focusing mode
Plug 'junegunn/limelight.vim'                                     " Extra focus mode
Plug 'altercation/vim-colors-solarized'                           " Solarized color scheme
Plug 'joshdick/onedark.vim' | Plug 'joshdick/airline-onedark.vim' " Atom type color scheme
Plug 'w0ng/vim-hybrid'
Plug 'chriskempson/base16-vim'
" Plug 'Rykka/riv.vim'


" Plug 'sheerun/vim-polyglot'                         " All the colors!
" Plug 'hdima/python-syntax', { 'for': 'python' }     " Python colors
Plug 'pearofducks/ansible-vim', { 'for': 'yaml' }
Plug 'elzr/vim-json', { 'for': 'json' }

" Nyaovim Plugins
Plug 'rhysd/nyaovim-markdown-preview'
Plug 'rhysd/nyaovim-mini-browser'
Plug 'tjdevries/nyaovim-popup-menu'

" Quickfix Modifications
Plug 'romainl/vim-qf'

" Folding
Plug 'tmhedberg/SimpylFold', { 'for': 'none' }  " Not used currently

" Web based plugins
Plug 'mattn/webapi-vim'
Plug 'jceb/vim-hier'
Plug 'dannyob/quickfixstatus'

" Vim help
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-projectionist'

" Task Warrior Plugins
" Plug 'blindFS/vim-taskwarrior'

" Encryption
" Plug 'd0c-s4vage/vim-morph'

call plug#end()
