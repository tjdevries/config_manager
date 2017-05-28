if exists('g:_did_vimrc_plugins')
    finish
endif

let g:_did_vimrc_plugins = 1

" vim-plug config {{{
" Extend the length of the timeout for vim-plug
let g:plug_timeout=60
" }}}

" Configure which plugins to use {{{
let g:my_snippet_manager = 'ultisnips'
let g:my_tags_manager = 'gutentags'
let g:my_current_scheme = 'gruvbox-tj'
let g:my_current_uniter = 'denite'
let g:my_deoplete_enabled = v:true
let g:airline_enabled = v:false
let g:vat_enabled = v:false
" }}}

" Plugin management: Vim-plug
call plug#begin(g:plugin_path)

" Plug 'C:\Users\tdevries\nvim_plug\vim-depends'
" Langerserver development
Plug 'tjdevries/nvim-langserver-shim'
Plug 'tjdevries/mparse.nvim'
" To Learn: {{{
" Intriguing
"
" For narrowing regions of text to look at them alone
Plug 'chrisbra/NrrwRgn'
" For figuring out exceptions
Plug 'tweekmonster/exception.vim'

Plug 'https://github.com/haya14busa/vim-metarepeat'
Plug 'rhysd/vim-clang-format'
if has('python3')
    Plug 'lambdalisue/lista.nvim'
endif

" Investigating
Plug 'tweekmonster/spellrotate.vim'

" Interested
Plug 'metakirby5/codi.vim'

" Ill
Plug 'tpope/vim-projectionist'  " Alternate file editting and some helpful stuff
Plug 'tpope/vim-scriptease'     " Vim help
" }}}

" Color helpers {{{
Plug 'chrisbra/Colorizer'                                         " Helpful tool for visualizing colors
" }}}
" Colorscheme and appearance {{{
Plug 'junegunn/goyo.vim'                                          " focusing mode
Plug 'junegunn/limelight.vim'                                     " Extra focus mode
Plug 'tjdevries/vim-inyoface'  " Comments in your face

" I use this to make my colorscheme
Plug 'tweekmonster/colorpal.vim'
" Old colorschemes
if v:false
    Plug 'altercation/vim-colors-solarized'                           " Solarized color scheme
    Plug 'chriskempson/base16-vim'
    Plug 'jacoborus/tender.vim'
    Plug 'joshdick/onedark.vim'                                       " Atom type color scheme
    Plug 'junegunn/seoul256.vim'                                      " seoul color scheme
    Plug 'w0ng/vim-hybrid'
    if isdirectory(expand('~/Git/gruvbox-tj'))
        Plug '~/Git/gruvbox-tj/'
    else
        Plug 'tjdevries/gruvbox-tj/'                                      " my gruvbox!
    endif
endif

" }}}
" Formatters {{{
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
" }}}
" Interactive Plugins {{{
if has('python2')
    Plug 'floobits/floobits-neovim'
endif

if has('python3')
    Plug 'bfredl/nvim-matrix'
endif
" }}}
" Git Based Plugins {{{

" Plug 'lambdalisue/vim-gita'
Plug 'lambdalisue/gina.vim'  " gita replacement
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'rhysd/committia.vim'      " Sweet message committer
Plug 'airblade/vim-gitgutter'   " Signs in the side for changes/additions/deletions
if v:false
    Plug 'moznion/github-commit-comment.vim'
    Plug 'SevereOverfl0w/deoplete-github'
    Plug '~/Git/githubapi-deoplete'
endif
" }}}
" Grep helpers {{{
Plug 'mhinz/vim-grepper'
" }}}
" Markdown Plugins {{{

" Not currently using these, because they add so much bloat
" and are a little obnoxious at times
"
" Plug 'vim-pandoc/vim-markdownfootnotes'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = [
            \ 'python=python',
            \ 'json=json',
            \ ]
" }}}
" Neovim development {{{
Plug 'tweekmonster/nvim-api-viewer'
Plug 'tweekmonster/nvimdev.nvim'
" }}}
" Neovim-qt {{{
Plug 'equalsraf/neovim-gui-shim'
" }}}
" Nyaovim Plugins {{{
Plug 'rhysd/nyaovim-markdown-preview'
Plug 'rhysd/nyaovim-mini-browser'
Plug 'rhysd/nyaovim-popup-tooltip'
if v:false
    if isdirectory('~/Git/nyaovim-popup-menu')
        Plug '~/Git/nyaovim-popup-menu'
    else
        Plug 'tjdevries/nyaovim-popup-menu'
    endif
endif
" }}}
" Presentation {{{
Plug 'trapd00r/vimpoint'
" }}}
" Quickfix Modifications {{{
Plug 'romainl/vim-qf'
" Plug 'jceb/vim-hier'
" Don't think I'm using this one
" Plug 'dannyob/quickfixstatus'
" }}}
" Searching {{{
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'tjdevries/edit_alternate.vim'
" }}}
" Snippets {{{
if g:my_snippet_manager ==? 'ultisnips'
    Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets'
elseif g:my_snippet_manager ==? 'neosnippet'
    Plug 'Shougo/neosnippet.vim' | Plug 'Shougo/neosnippet-snippets' | Plug 'honza/vim-snippets'
endif
" }}}
" {{{1 Shougo
" Unite {{{
if g:my_current_uniter ==? 'unite'
    Plug 'Shougo/vimproc.vim'
    Plug 'Shougo/unite.vim'
    Plug 'ujihisa/unite-colorscheme'    " Cycle through color schemes

    Plug 'klen/unite-radio.vim'         " Play radio stations
    Plug 'tsukkee/unite-tag'            " Tag finder for unite
elseif g:my_current_uniter ==? 'denite'
    if has('python3')
        Plug 'Shougo/denite.nvim'

        Plug 'Shougo/neomru.vim'            " Most recently used files
        if has('clipboard')
            Plug 'Shougo/neoyank.vim'           " Yank ring for my uniter
        endif
    endif
endif

" }}}
"
if has('python3')
    Plug 'Shougo/deol.nvim'
endif
" Deoplete  {{{
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/neoinclude.vim'

if has('python3') && g:my_deoplete_enabled
    Plug 'Shougo/deoplete.nvim'

    Plug 'zchee/deoplete-jedi',  { 'for': 'python' }   "  Python
    Plug 'Shougo/neco-vim'                             "  Vim completion
    Plug 'Shougo/neco-syntax'                          "  Vim syntax completion
    Plug 'tweekmonster/deoplete-clang2'                 " C-Family languages
    Plug 'eagletmt/neco-ghc'
    Plug 'mhartington/nvim-typescript'
    " Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    " Plug 'zchee/deoplete-clang'                        "  C-Family languages
    " Plug 'xolox/vim-lua-ftplugin', { 'for': 'lua' }
    " Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'html', 'htmldjango'] }
endif
" }}}
" }}}
" Startup {{{
Plug 'mhinz/vim-startify'
" }}}
" Status Line {{{
if g:airline_enabled
    Plug 'powerline/fonts', { 'do': './install.sh' }
    Plug 'bling/vim-airline'
endif
Plug 'mkitt/tabline.vim'
" }}}
" Syntax Checkers {{{
" Plug 'benekastah/neomake'       " A better linter than syntastic?
Plug 'alfredodeza/pytest.vim'   " Pytest helper
" }}}
" Syntax Highlighters {{{
Plug 'justinmk/vim-syntax-extra'                                                               " C, bison, flex
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }                                   " javascript
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'html', 'htmldjango'] } " javascript extra
Plug 'elzr/vim-json', { 'for': 'json' }                                                        " json
Plug 'goodell/vim-mscgen'                                                                      " mscgen
Plug 'pearofducks/ansible-vim', { 'for': 'yaml' }                                              " yaml
Plug 'PProvost/vim-ps1'
Plug 'leafgarland/typescript-vim'
Plug 'billyvg/tigris.nvim', { 'do': './install.sh' }

" Too large or not helpful
" Plug 'sheerun/vim-polyglot'                         " All the colors!
" Plug 'hdima/python-syntax', { 'for': 'python' }     " Python colors
" }}}
" Tag Based Plugins {{{
if g:my_tags_manager ==? 'gutentags'
    Plug 'ludovicchabant/vim-gutentags'
elseif g:my_tags_manager ==? 'vim-tags'
    Plug 'szw/vim-tags'
elseif g:my_tags_manager ==? 'easytags'
    Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
endif

" Tagbar for registers basically
" These were seriously slowing things down for me,
" well they tagbar one was, peakaboo had a conflicting command
" Plug 'majutsushi/tagbar'
" Plug 'junegunn/vim-peekaboo'
" }}}
" Testing my plugins {{{
Plug 'tjdevries/pastery.vim'

if g:vat_enabled
    Plug 'neovim/node-host', { 'do': 'npm install' }
    Plug 'tjdevries/vat.nvim', { 'do': 'npm install' }
endif

if v:false
    Plug 'tjdevries/vim-vertex'
    Plug '~/Git/a_highlighter.nvim/'
    Plug 'tjdevries/a_highlighter.nvim'
    " This plugin is not ready
endif
" }}}
" Testing plugins {{{
Plug 'janko-m/vim-test'
Plug 'junegunn/vader.vim'
" }}}
" Text Manipulation Based Plugins {{{
Plug 'godlygeek/tabular'        " Quickly align text by pattern
Plug 'tpope/vim-surround'       " Surround text objects easily
Plug 'tpope/vim-speeddating'    " Handle changing of dates in a nicer manner
Plug 'tpope/vim-commentary'     " Easily comment out lines or objects
Plug 'tpope/vim-repeat'         " Repeat actions better
Plug 'tpope/vim-abolish'        " Cool things with words!
Plug 'tpope/vim-sleuth'         " Easier tab handling
Plug 'kana/vim-textobj-user' | Plug 'bps/vim-textobj-python', { 'for': 'python' }
Plug 'tpope/vim-characterize'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/sideways.vim' " Easy sideways movement

Plug 'tweekmonster/impsort.vim', {'for': 'python'}
Plug 'tweekmonster/braceless.vim', {'on': 'BracelessEnable'}

Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }     " Get python alignment to work correctly
Plug 'nathanaelkane/vim-indent-guides'                       " See indentation guides
" }}}
" Undo plugins {{{
Plug 'sjl/gundo.vim'                " Undo helper
" }}}
" {{{ Vim Plugins
Plug 'tweekmonster/nvim-api-viewer'
" }}}
" Web based plugins {{{
Plug 'mattn/webapi-vim'
" }}}
" Web Development {{{
Plug 'mattn/emmet-vim'
Plug 'vim-scripts/JavaScript-Indent',  { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'html']}
Plug 'tpope/vim-liquid'
" }}}
" Wiki {{{
Plug 'vimwiki/vimwiki'
" }}}


" Old plugins... {{{
" Task Warrior Plugins
" Plug 'blindFS/vim-taskwarrior'

" Encryption
" Plug 'd0c-s4vage/vim-morph'
"
" Plug 'TheZoq2/neovim-auto-autoread'     " Autoread files in neovim, use AutoreadLoop
" Plug 'scrooloose/syntastic'
" Plug 'klen/python-mode', { 'for': 'python' } " Not sure I like this one
" Plug 'ervandew/supertab',     {  'for': 'python' }    " Completion thing
" Plug 'dbsr/vimpy', { 'for': 'python' ]        " Removes unused imports
" maybe?
" YouCompleteMe, not using right now. Went for Deoplete
" Plug 'valloric/youcompleteme', { 'do': './install.py --clang-completer --gocode-completer' }
" Plug 'junegunn/fzf', { 'do': './install --all'}     " Fuzzy Searcher
" Plug 'junegunn/fzf.vim'                             " Fuzzy Search NOW WITH VIM!
" Plug 'Rykka/riv.vim'
" Folding
" Plug 'tmhedberg/SimpylFold', { 'for': 'none' }  " Not used currently
" }}}
call plug#end()

" Load immediately {{{
" call plug#load('descriptive_maps.vim')
call plug#load('vim-abolish')
" }}}
