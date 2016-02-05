" Neovim specific configuration file

" {{{ TODO
" Find a way to do color schemes with vim-plug
" Figure out how to use ctrl-p
" }}}
" {{{ Unix vs. Windows Configuration
if has('unix')
    let g:python_host_prog = '/usr/bin/python'
    let g:python3_host_prog = '/usr/bin/python3'
else
    let g:python_host_pgro = 'C:\python'
endif
" }}}
" {{{ vim-plug configuration

" Automatically installs vim-plug if not already there
" if empty(glob('~/.vim/autoload/plug.vim'))
"   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall | source $MYVIMRC
" endif

" Extend the length of the timeout for vim-plug
let g:plug_timeout=600

" Plugin management: Vim-plug
"   Choose the correct path
if has('unix')
    let g:plugin_path = '~/.vim/plugged'
else
    let g:plugin_path = 'C:/neovim/'
endif

call plug#begin(g:plugin_path)

" Fun status line
Plug 'bling/vim-airline'

" Syntax Type Plugins
" Plug 'scrooloose/syntastic'
" Plug 'klen/python-mode', { 'for': 'python' } " Not sure I like this one
Plug 'benekastah/neomake'       " A better linter than syntastic?

" UltiSnips
Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets'

" Deoplete
Plug 'Shougo/deoplete.nvim',  {  'on': 'DeopleteEnable' }
Plug 'Shougo/neoinclude.vim', {  'on': 'DeopleteEnable' }
Plug 'davidhalter/jedi-vim',  {  'for': 'python' }
Plug 'ervandew/supertab',     {  'for': 'python' }

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
" }}}
" {{{ Vim default behaviors
set completeopt-=preview " Turn off preview
set splitright           " Prefer windows splitting to the right
set splitbelow           " Prefer windows splitting to the bottom
set updatetime=250       " Make updates happen faster
set nohlsearch
" }}}
" {{{ Folding behvaiors
set foldmethod=marker
set foldlevel=0
set modelines=1
" }}}
" {{{ Deoplete
function StartDeoplete()
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#auto_completion_start_length = 1
    let g:deoplete#enable_smart_case = 1

    "   Python completion
    augroup Python
        autocmd FileType python setlocal omnifunc=jedi#completions
    augroup END
    let g:jedi#completions_enabled = 0
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#smart_auto_mappings = 0
    let g:jedi#show_call_signatures = 0
endfunction

"   Make tab perform the completion for deoplete
" inoremap <silent><expr> <Tab>
"             \ pumvisible() ? "\<C-n>" :
"             \ deoplete#mappings#manual_complete()
" }}}
" {{{ Neomake
" Automatically run Neomake on write
if !exists('neomake_config_done')
    let g:neomake_config_done = 1
    autocmd BufWritePost *  Neomake
    
    " Automatically open the error window
    let g:neomake_open_list = 1

    " Python
    " let g:neomake_python_flake8_maker = {
    "         \ 'args': ['--max-line-length=120 --format="|%(row)4d |%(col)4d | %(code)s: %(text)s"']
    "         \ }

    let g:neomake_python_enabled_makers = [ 'flake8' ]

    " Vim
    let g:neomake_vimscript_enabled_makers = [ 'vint' ]
endif
" }}}
" {{{ Colorscheme
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1   " Turn on better color support in vim
let g:gruvbox_italic=1              " Turn on italics for gruvbox
colorscheme gruvbox

set background=dark
" }}}
" {{{ Airline Configuration
let g:airline_powerline_fonts=1
" let g:airline_section_a = 'hello'
" let g:airline_section_z = 'column'

let g:airline_inactive_collapse = 1 " Only indicate filename on inactive buffers
let g:airline_exclue_preview = 1 " Don't show status line in preview
let g:airline#extensions#branch#empty_message = 'HEADLESS' " No Branch Message
let g:airline#extensions#branch#format = 2 " See documentation
" }}}
" {{{ Tagbar Configuration
" }}}
" {{{ Nyaovim Markdown Preview
" Only apply if it is loaded
if exists(':StartMarkdownPreview')
    let g:markdown_preview_auto = 1
    let g:markdown_preview_eager = 1 
endif
" }}}
" {{{ Python
augroup python
    au!
    let g:jedi#force_py_version = 3

augroup END
" }}}

" vim:foldmethod=marker:foldlevel=0
