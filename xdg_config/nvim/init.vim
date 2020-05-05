scriptencoding utf-8

" Neovim specific configuration file
"
" Plugin configuration in ./after/plugin/

let g:_vimrc_base = expand('<sfile>:p:h')
let g:_vimrc_plugins = g:_vimrc_base . '/after/plugin'

if has('unix')
    let g:plugin_path = expand('~/.config/vim_plug')
else
    let g:plugin_path = expand('$HOME') . '\nvim_plug'
endif

if get(g:, 'gonvim_running', 0)
  execute 'source ' . g:_vimrc_base . '/ginit.vim'
endif

" vim-plug config {{{
" Extend the length of the timeout for vim-plug
let g:plug_timeout=60

" Configure which plugins to use {{{
let g:my_snippet_manager = 'ultisnips'
let g:my_current_scheme = 'gruvbox-tj'
let g:my_deoplete_enabled = v:false
let g:airline_enabled = v:false

let g:builtin_lsp = v:true
" }}}

function! s:local_plug(package_name) abort " {{{
  if isdirectory(expand("~/plugins/" . a:package_name))
    execute "Plug '~/plugins/".a:package_name."'"
  else
    execute "Plug 'tjdevries/" .a:package_name."'"
  endif
endfunction
" }}}
" Plugin management: Vim-plug
call plug#begin(g:plugin_path)

" Local plugins {{{
if filereadable(expand("~/plugins/viki/readme.md"))
  Plug '~/plugins/viki/'
else
  " TODO: Push to github
endif

" TODO: vimptyer
" TODO: pyne


if file_readable(expand("~/plugins/standard.lua/README.md"))
  Plug '~/plugins/standard.lua/'
else
  Plug 'tjdevries/standard.lua'
endif

call s:local_plug('luvjob.nvim')
call s:local_plug('apyrori.nvim')
call s:local_plug('py_package.nvim')
call s:local_plug('manillua.nvim')

" }}}
" To Learn: {{{
" Yup:
" Plug 'https://github.com/AndrewRadev/linediff.vim'
" Plug 'https://github.com/AndrewRadev/switch.vim'
"
" Intriguing
"
" For narrowing regions of text to look at them alone
Plug 'chrisbra/NrrwRgn'

" For figuring out exceptions
Plug 'tweekmonster/exception.vim'

Plug 'haya14busa/vim-metarepeat'
Plug 'rhysd/vim-clang-format'
if has('python3')
  Plug 'lambdalisue/lista.nvim'
endif

" Investigating
Plug 'tweekmonster/spellrotate.vim'

" Ill
Plug 'tpope/vim-projectionist'  " Alternate file editting and some helpful stuff
Plug 'tpope/vim-scriptease'     " Vim help
" }}}
" LSP {{{

" Yo, we got lsp now
Plug 'neovim/nvim-lsp'

if g:my_deoplete_enabled
  Plug 'Shougo/deoplete-lsp'
else
  Plug 'haorenW1025/completion-nvim'

  set completeopt=menuone,noinsert,noselect
endif

" Cool tags based viewer
Plug 'liuchengxu/vista.vim'

" Debug adapter protocol
Plug 'puremourning/vimspector'

" Better diagnostics
Plug 'haorenW1025/diagnostic-nvim'
" }}}
" My General Plugins {{{
Plug 'tjdevries/standard.vim'
Plug 'tjdevries/conf.vim'

Plug 'tjdevries/train.vim'

" In development: Working on updating this
Plug 'tjdevries/syntax_objects.vim'
" }}}
" Python Work Plugins {{{
if has('python3')
  " Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
  "
  " I gave up on this plugin for now
  " Plug 'tjdevries/nycharm'
endif

" Pytest mapper
Plug 'alfredodeza/pytest.vim'
" }}}
" Epic (the company) Plugins {{{

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

if filereadable('F:\personal\tdevries\work_git\epic.vim\plugin\epic.vim')
  Plug 'F:\\personal\\tdevries\\work_git\\epic.vim\'
endif

Plug 'tjdevries/mparse.nvim'
Plug 'tjdevries/putty.vim'
" }}}
" Color helpers {{{
if has('nvim-0.4')
  Plug 'norcalli/nvim-colorizer.lua'
else
  " Helpful tool for visualizing colors
  Plug 'chrisbra/Colorizer'
endif
" }}}
" Colorscheme and appearance {{{
" focusing mode
Plug 'junegunn/goyo.vim'
" Extra focus mode
Plug 'junegunn/limelight.vim'
" Comments in your face
Plug 'tjdevries/vim-inyoface'

" I use this to make my colorscheme
Plug 'tjdevries/colorbuddy.vim'

" }}}
" Formatters {{{
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt', { 'on': 'FormatCode' }
Plug 'google/vim-glaive'
" }}}
" Interactive Plugins {{{
if has('python2') && v:false
  Plug 'floobits/floobits-neovim'
endif

if has('python3') && v:false
  " TODO: Get a matrix account...
  Plug 'bfredl/nvim-matrix'
endif
" }}}
" {{{ Games
Plug 'johngrib/vim-game-snake'
Plug 'johngrib/vim-game-code-break'
" }}}
" Git Based Plugins {{{
Plug 'lambdalisue/gina.vim'   " gita replacement
Plug 'tpope/vim-rhubarb'      " completes issue names in commit messages
Plug 'junegunn/gv.vim'
Plug 'rhysd/committia.vim'    " Sweet message committer

Plug 'rhysd/git-messenger.vim'  " Floating windows are awesome :)

if has('unix')
  Plug 'airblade/vim-gitgutter' " Signs in the side for changes/additions/deletions
endif

if v:false
  Plug 'moznion/github-commit-comment.vim'
  Plug 'SevereOverfl0w/deoplete-github'
  Plug '~/Git/githubapi-deoplete'
endif
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

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
" }}}
" Neovim development {{{
if has('unix')
  Plug 'tweekmonster/nvim-api-viewer'
  Plug 'tweekmonster/nvimdev.nvim'
endif
" }}}
" Neovim-qt {{{
Plug 'equalsraf/neovim-gui-shim'
" }}}
" Presentation {{{
"
" TODO: Will probably switch to lookatme for presentations, since it's awesome
if v:false
  Plug 'tjdevries/vimpoint'
endif
Plug 'trapd00r/vimpoint'
" }}}
" Quickfix Modifications {{{
Plug 'romainl/vim-qf'
" }}}
" {{{ REPL Plugins
Plug 'Vigemus/iron.nvim'

" Interested
" Plug 'metakirby5/codi.vim'

" }}}
" Searching {{{
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'tjdevries/edit_alternate.vim'
Plug 'google/vim-searchindex'
Plug 'skywind3000/quickmenu.vim'
Plug 'tjdevries/fold_search.vim'
" }}}
" Snippets {{{
if g:my_snippet_manager ==? 'ultisnips'
  if has('python3')
    Plug 'sirver/ultisnips'
  endif

  " TODO: Will consider adding this back, but really should make my own snippets that I'll remember :)
  " Plug 'honza/vim-snippets'
elseif g:my_snippet_manager ==? 'neosnippet'
  Plug 'Shougo/neosnippet.vim' | Plug 'Shougo/neosnippet-snippets' | Plug 'honza/vim-snippets'
endif
" }}}
" {{{ Shougo
" Denite {{{
if has('python3')
  Plug 'Shougo/denite.nvim'

  Plug 'Shougo/neomru.vim'            " Most recently used files

  if has('clipboard') && has('unix')
    Plug 'Shougo/neoyank.vim'           " Yank ring for my uniter
  endif
endif
" }}}
"
if has('python3')
  Plug 'Shougo/deol.nvim'
endif
" Deoplete  {{{
if has('unix')
  Plug 'Shougo/echodoc.vim'
  Plug 'Shougo/context_filetype.vim'
endif


Plug 'Shougo/neco-vim'

if has('python3') && g:my_deoplete_enabled
  Plug 'Shougo/deoplete.nvim'

  " Plug 'zchee/deoplete-jedi',  { 'for': 'python' }
  Plug 'Shougo/neco-syntax'

  if executable('zsh')
    Plug 'deoplete-plugins/deoplete-zsh'
  endif

  if executable('racer') " TODO: Maybe check racer?
    Plug 'rust-lang/rust.vim'                        " Realistically. we only need this when we have rust as well
    Plug 'sebastianmarkow/deoplete-rust'             " Rust completion
  endif

  " Gotta choose electric boogaloo
  Plug 'tweekmonster/deoplete-clang2'                 " C-Family languages

  " Works, but not using
  " Plug 'eagletmt/neco-ghc'

  " Emojis :)
  Plug 'fszymanski/deoplete-emoji'

  " Can't seem to get to work on windows as of right now.
  " Will make an issue if I can't figure it out.
  if executable('tsc') && has('unix')
    Plug 'mhartington/nvim-typescript', {'for': 'typescript'}
  endif

endif
" }}}
" }}}
" Startup {{{
Plug 'mhinz/vim-startify'
Plug 'tweekmonster/startuptime.vim'
" }}}
" Status Line {{{
" Inspiration for my tabline
if v:false
  Plug 'tjdevries/tabline.nvim'
else
  Plug 'mkitt/tabline.vim'
endif

Plug 'ryanoasis/vim-devicons'
" }}}
" Syntax Configs {{{
"
" Might want to review these and see if there are better options now.
Plug 'neovimhaskell/haskell-vim'
Plug 'justinmk/vim-syntax-extra'                                                               " C, bison, flex
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }                                   " javascript
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'html', 'htmldjango'] } " javascript extra
Plug 'elzr/vim-json', { 'for': 'json' }                                                        " json
Plug 'goodell/vim-mscgen'                                                                      " mscgen
Plug 'pearofducks/ansible-vim', { 'for': 'yaml' }                                              " yaml
Plug 'PProvost/vim-ps1'
Plug 'leafgarland/typescript-vim'
Plug 'cespare/vim-toml'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'tpope/vim-liquid'
" }}}
" Tag Based Plugins {{{
if executable('ctags')
  Plug 'jsfaint/gen_tags.vim'

  if has('unix')
    Plug 'majutsushi/tagbar'
  endif
endif

" Tagbar for registers basically
" These were seriously slowing things down for me,
" well they tagbar one was, peakaboo had a conflicting command
" Plug 'junegunn/vim-peekaboo'
" }}}
Plug 'tjdevries/pastery.vim'
Plug 'tjdevries/overlength.vim'

" Testing plugins {{{
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

Plug 'nathanaelkane/vim-indent-guides'                       " See indentation guides
" }}}
" Undo plugins {{{
Plug 'sjl/gundo.vim'                " Undo helper
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
" Plug 'tjdevries/vimwiki'
Plug 'lervag/wiki.vim'
" }}}

Plug 'junegunn/fzf', { 'do': './install --all'}     " Fuzzy Searcher
Plug 'yuki-ycino/fzf-preview.vim'

call plug#end()
" }}}

" Packadd plugins
packadd vimball

let g:init_base = fnamemodify(expand('$MYVRIMRC'), ':h')

" Set our leader key to ,
let g:mapleader=','

" Set important paths
if has('unix')
  " You have to set these up using pip install.
  " I usually do something with pyenv, since I find it easy
  "
  " $ pyenv install 3.5.2
  " $ pyenv virtualenv 3.5.2 neovim3
  " ... 
  "
  " Something like that
  if glob('~/.pyenv/versions/neovim2/bin/python') != ''
    let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
    let g:python2_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
  else
    let g:python_host_prog = 'python'
    let g:python2_host_prog = 'python2'
  endif

  if glob('~/.pyenv/versions/neovim3/bin/python') != ''
    let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
  else
    let g:python3_host_prog = systemlist('which python3')[0]
  endif
else
  let $PATH='C:\Users\tdevries\Downloads\Neovim\Neovim\bin\;' . $PATH

  " Will need to figure out the best way to do this once I start using windows again
  let g:python_host_prog = 'C:\python'
  let g:python3_possibilities = [
        \  expand('$HOME') . '\AppData\Local\Programs\Python\Python36\python.exe',
        \  expand('$HOME') . '\AppData\Local\Programs\Python\Python36-32\python.exe',
        \ 'python3',
        \ 'python3.6',
        \ 'C:\Program Files\Python35\python.exe',
        \ ]

  for py_exe in g:python3_possibilities
    if executable(py_exe)
      let g:python3_host_prog = py_exe
      break
    endif
  endfor

  " let g:loaded_ruby_provider = 1
endif

filetype plugin indent on

set wildignore+=*.o,*~,*.pyc,*pycache* " Ignore compiled files
set wildignore+=__pycache__

if has('nvim-0.4')
  " Use cool floating wildmenu options
  set pumblend=17

  set wildmode-=list
  set wildmode+=longest
  set wildmode+=full

  set wildoptions+=pum
else
  set wildmode=longest,list,full

  " Vim Galore recommended mappings
  " Make next and previous use smart history
  cnoremap <C-N> <Up>
  cnoremap <C-P> <Down>
end

" then list them, then full
set noshowmode
set cmdheight=1                       " Height of the command bar
set incsearch                         " Makes search act like search in modern browsers
set showmatch                         " show matching brackets when text indicator is over them
set relativenumber                    " Show line numbers
set number                            " But show the actual number for the line we're on
set ignorecase                        " Ignore case when searching...
set smartcase                         " ... unless there is a capital letter in the query
set hidden                            " I like having buffers stay around

set cursorline    " Highlight the current line


let g:my_preview_enable = v:false
if g:my_preview_enable
  set completeopt+=preview              " Turn On preview
else
  set completeopt-=preview              " Turn off preview
endif

set noequalalways                     " I don't like my windows changing all the time
set splitright                        " Prefer windows splitting to the right
set splitbelow                        " Prefer windows splitting to the bottom
set updatetime=4000                   " Make updates happen faster

" I wouldn't use this without my DoNoHL function
set hlsearch

set scrolloff=10                      " Make it so there are always ten lines below my cursor

" Tabs
" Want auto indents automatically
set autoindent
set cindent
set wrap

" Set the width of the tab to 4 wide
" This gets overridden by vim-sleuth, so that's nice
set tabstop=4
set shiftwidth=4
set softtabstop=4

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

" Just turn the dang bell off
set belloff=all

" Clipboard
" Always have the clipboard be the same as my regular clipboard
set clipboard+=unnamedplus

" Configure Inccommand
if exists('&inccommand')
  set inccommand=split

  function! CycleIncCommand() abort
    if &inccommand ==? 'split'
      set inccommand=nosplit
    else
      set inccommand=split
    endif
  endfunction

  nnoremap <leader>ci :call CycleIncCommand()<CR>
endif

" Listchars
set list

if &list
  " Some fun characters:
  " ▸
  " ⇨
  let g:list_char_index = 0
  let g:list_char_options = [
        \ 'tab:»\ ,eol:↲,nbsp:␣,extends:…,precedes:<,extends:>,trail:·',
        \ 'tab:»·,eol:↲,nbsp:␣,extends:…,precedes:<,extends:>,trail:·,space:␣',
        \ 'tab:\ \ ,eol:↲,nbsp:␣,extends:…,precedes:<,extends:>,trail:·,space:␣',
        \ '',
        \ ]
  function! CycleListChars() abort
    execute 'set listchars=' . g:list_char_options[
            \ float2nr(
              \ fmod(g:list_char_index, len(g:list_char_options))
            \ )
          \ ]

    let g:list_char_index += 1
  endfunction

  " Cycle through list characters
  " Useful as a helper
  nnoremap <leader>cl :call CycleListChars()<CR>
endif

lua require('gruvbuddy')

" guicursor messing around
" set guicursor=n:blinkwait175-blinkoff150-blinkon175-hor10
" set guicursor=a:blinkon0

" disable netrw.vim
" let g:loaded_netrw             = 1
" let g:loaded_netrwPlugin       = 1
" let g:loaded_netrwSettings     = 1
" let g:loaded_netrwFileHandlers = 1

" vim:foldmethod=marker:foldlevel=0
