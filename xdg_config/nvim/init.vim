"      __________________    __
"     /_  __/ ____/ ____/   / /    TJ DeVries
"      / / / __/ / __/ __  / /     https://github.com/tjdevries
"     / / / /___/ /___/ /_/ /      https://twitch.tv/teej_dv
"    /_/ /_____/_____/\____/
"
scriptencoding utf-8

" Neovim specific configuration file
"
" Plugin configuration in ./after/plugin/

let g:_vimrc_base = expand('<sfile>:p:h')

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

let g:builtin_lsp = v:true
" }}}

" Packadd plugins
packadd vimball

lua require('plugins')

let g:init_base = fnamemodify(expand('$MYVRIMRC'), ':h')

" Set our leader key to ,
let g:mapleader=','

" Set important paths {{{
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
endif " }}}

filetype plugin indent on

set wildignore+=*.o,*~,*.pyc,*pycache* " Ignore compiled files
set wildignore+=__pycache__

if has('nvim-0.4')
  " Use cool floating wildmenu options
  set pumblend=17

  set wildmode-=list
  set wildmode+=longest
  set wildmode+=full

  " Makes floating PopUpMenu for completing stuff on the command line.
  "     Very similar to completing in insert mode.
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

set cursorline                        " Highlight the current line


set completeopt-=preview              " Turn off preview

set noequalalways                     " I don't like my windows changing all the time
set splitright                        " Prefer windows splitting to the right
set splitbelow                        " Prefer windows splitting to the bottom
set updatetime=1000                   " Make updates happen faster

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

set inccommand=split
set list

syntax enable

set noswapfile

if has('nvim') && executable('nvr')
  let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

" guicursor messing around
" set guicursor=n:blinkwait175-blinkoff150-blinkon175-hor10
" set guicursor=a:blinkon0

" disable netrw.vim
" let g:loaded_netrw             = 1
" let g:loaded_netrwPlugin       = 1
" let g:loaded_netrwSettings     = 1
" let g:loaded_netrwFileHandlers = 1
