scriptencoding utf-8

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
  if executable('~/.pyenv/versions/neovim2/bin/python')
    let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
    let g:python2_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
    let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
  else
  endif
else
  " Will need to figure out the best way to do this once I start using windows again
  let g:python_host_prog = 'C:\python'
endif

filetype plugin indent on

set wildignore=*.o,*~,*.pyc,*pycache* " Ignore compiled files
set wildmode=longest,list,full        " Complete the longest common string,
" then list them, then full
set noshowmode
set cmdheight=1                       " Height of the command bar
set incsearch                         " Makes search act like search in modern browsers
set showmatch                         " show matching brackets when text indicator is over them
set relativenumber                    " Show line numbers
set number                            " But show the actual number for the line we're on
set ignorecase                        " Ignore case when searching...
set smartcase                         " ... unless there is a capital letter in the query

let g:my_preview_enable = v:false
if g:my_preview_enable
  set completeopt+=preview              " Turn On preview
  " Lots of people don't like this one. I don't mind
  " and sometimes it provides really helpful stuff
else
  set completeopt-=preview              " Turn off preview
endif

set noequalalways                     " I don't like my windows changing all the time
set splitright                        " Prefer windows splitting to the right
set splitbelow                        " Prefer windows splitting to the bottom
set updatetime=250                    " Make updates happen faster

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
        \ 'tab:»·,eol:↲,nbsp:␣,extends:…,precedes:<,extends:>,trail:·',
        \ 'tab:»·,eol:↲,nbsp:␣,extends:…,precedes:<,extends:>,trail:·,space:␣',
        \ '',
        \ ]
  function! CycleListChars() abort
    execute 'set listchars=' . g:list_char_options[
          \ float2nr(
          \fmod(g:list_char_index, len(g:list_char_options))
          \ )
          \ ]

    let g:list_char_index += 1
  endfunction

  nnoremap <leader>cl :call CycleListChars()<CR>
endif
