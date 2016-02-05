" TJ's Vimrc

" {{{ Neovim Configuration
if has('nvim')
    if has('unix')
        source ~/.config/nvim/.nvimrc
    else
        " Windows pathway
        source ~\Documents\GitHub\config_manager\vim\.nvimrc
    endif
else
    source ~/.config/vim/.specific.vimrc
endif
" }}}
" {{{ Leader
" Set our leader key to ,
let g:mapleader=','
" }}}
" {{{ General VIM configuration
set wildignore=*.o,*~,*.pyc " Ignore compiled files
set cmdheight=2             " Height of the command bar
set incsearch               " Makes search act like search in modern browsers
set showmatch               " show matching brackets when text indicator is over them
set relativenumber          " Show line numbers
set number                  " But show the actual number for the line we're on

" Load filetype-specific indent files
" Also enables plugins?
filetype plugin indent on

" Spell check
" set spelllang=en_us
" set spell

set scrolloff=10            " Make it so there are always ten lines below my cursor
" }}}
" {{{ Tab Configuration
" Want auto indents automatically
set autoindent
set cindent
set wrap

" Set the width of the tab to 4 wid
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Make it so that long lines wrap smartly
set breakindent
let &showbreak=repeat(' ', 3)
set linebreak

" Always use spaces instead of tab characters
set expandtab
" }}}
" {{{ UltiSnip Configuration
" Trigger configuration.
let g:UltiSnipsExpandTrigger='<leader>e'
let g:UltiSnipsJumpForwardTrigger='<leader>r'
let g:UltiSnipsJumpBackwardTrigger='<leader>w'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'

" Use Python Version
let g:UltiSnipsUsePythonVersion = 2
" }}}
" {{{ ctags
set tags=tags; " Enable ctags
" }}}
" {{{ Markdown Configuration
augroup markdown
    " remove buffer-local auto commands forcurrent buffer
    au!
    " hook to run TableFormat when <bar> is entered in insert mode
    au FileType mkd.markdown exec 'inoremap \| \|<C-O>:TableFormat<CR><C-O>f\|<right>'
    " Ctrl+\ will run TableFormat in either mode
    au FileType mkd.markdown exec 'inoremap <C-\> <C-O>:TableFormat<CR>'
    au FileType mkd.markdown exec 'noremap <silent> <C-\> :TableFormat<CR>'

    let g:vim_markdown_folding_disabled=1
augroup END
" }}}
" {{{ Python configuration
augroup python
    au!
    autocmd BufWritePre *.py :%s/\s\+$//e
augroup END
" }}}
" {{{ Color Configuration
" Enable syntax highlighting
syntax enable

" Choose Color scheme
" Now done in vim vs nvim configs
" }}}
" {{{ VERY IMPORTANT KEYBINDINGS
nnoremap <Up>          :echom "--> k <-- "<CR>
nnoremap <Down>        :echom "--> j <-- "<CR>
nnoremap <Right>       :echom "--> l <-- "<CR>
nnoremap <Left>        :echom "--> h <-- "<CR>

inoremap <Up>     <C-o>:echom "--> k <-- "<CR>
inoremap <Down>   <C-o>:echom "--> j <-- "<CR>
inoremap <Right>  <C-o>:echom "--> l <-- "<CR>
inoremap <Left>   <C-o>:echom "--> h <-- "<CR>

nnoremap ; :

" Set jj to be escape in insert mode
inoremap jj <esc>

" For long, wrapped lines
nnoremap k gk
nnoremap j gj
" }}}
" {{{ Old stuff
" ------------------------- Old Items: Kept for Reference -------------------------
" ----- Flake8 Things -----
" Run flake8() whenever a python file is written
" autocmd BufWritePost *.py call Flake8()
" Trying to do this using syntastic now. Refer above

" ----- Status Line (Python) -----
" This currently doesn't work
" python from powerline.vim import setup as powerline_setup
" python powerline_setup()
" python del powerline_setup
" }}}
