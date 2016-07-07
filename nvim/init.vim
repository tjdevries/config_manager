" Neovim specific configuration file

" {{{ Leader
" Set our leader key to ,
let g:mapleader=','
" }}}
" {{{ TODO
" Find a way to do color schemes with vim-plug
" Figure out how to use ctrl-p
" Tagbar + statusline configuration
" }}}
" {{{ Unix vs. Windows Configuration
if has('unix')
    let g:python_host_prog = '/usr/bin/python'
    let g:python2_host_prog = '/usr/bin/python2'
    let g:python3_host_prog = '/usr/bin/python3'
else
    let g:python_host_prog = 'C:\python'
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

" Snippets
Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets'
" Plug 'Shougo/neosnippet.vim' | Plug 'Shougo/neosnippet-snippets' | Plug 'honza/vim-snippets'

" {{{2 Shougo
" Unite
Plug 'Shougo/unite.vim'

" Deoplete  {{{
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neoinclude.vim'

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
" Plug 'ludovicchabant/vim-gutentags' " I could not get this to work.
" Plug 'szw/vim-tags' " I could not get this one to work either
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
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
" }}}
" {{{ Neovim Configuration
" }}}
" {{{ General VIM configuration
set wildignore=*.o,*~,*.pyc " Ignore compiled files
set cmdheight=2             " Height of the command bar
set incsearch               " Makes search act like search in modern browsers
set showmatch               " show matching brackets when text indicator is over them
set relativenumber          " Show line numbers
set number                  " But show the actual number for the line we're on
set ignorecase              " Ignore case when searching...
set smartcase               " ... unless there is a capital letter in the query

" Load filetype-specific indent files
" Also enables plugins?
filetype plugin indent on

" Spell check
" set spelllang=en_us
" set spell
"
set completeopt+=preview " Turn On preview
set splitright           " Prefer windows splitting to the right
set splitbelow           " Prefer windows splitting to the bottom
set updatetime=250       " Make updates happen faster
set nohlsearch

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
" {{{ Snippet Configuration
let snippet_manager = 'ultisnips'
if snippet_manager == 'ultisnips'
    " Configuration for custom snips
    let g:UltiSnipsSnippetsDir = "~/.config/nvim/snips"
    let g:UltiSnipsSnippetDirectories = ["UltiSnips", "snips"]

    " Trigger configuration.
    let g:UltiSnipsExpandTrigger='<leader>e'
    let g:UltiSnipsJumpForwardTrigger='<leader>r'
    let g:UltiSnipsJumpBackwardTrigger='<leader>w'

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit='vertical'

    " Use Python Version
    let g:UltiSnipsUsePythonVersion = 3

    let g:ultisnips_python_style="google"
elseif snippet_manager == 'neosnippet'
    let g:neosnippet#snippets_directory = ["~/.config/nvim/snips/", g:plugin_path . "/vim-snippets/"]

    let g:neosnippet#enable_snipmate_compatibility = 1

    imap <C-k>  <Plug>(neosnippet_expand_or_jump)
endif
" }}}
" {{{ ctags
" set tags=tags; " Enable ctags

let g:easytags_file = '~/.cache/tags'
let g:easytags_async = 1    " Background support for easy tags
let g:easytags_event = ['BufWritePost'] " Update the tags after writing
" Some highlight support is included in easytags
" highlight pythonFunctionTag <insert command>
"
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

" Set kj to be escape in insert mode
inoremap kj <esc>

" For long, wrapped lines
nnoremap k gk
nnoremap j gj

" Map execute this line
nnoremap <leader>x :exe getline(".")<CR>
vnoremap <leader>x :<C-w>exe join(getline("'<","'>"),'<Bar>')<CR>
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
" {{{ Folding behvaiors
set foldmethod=marker
set foldlevel=0
set modelines=1
" }}}
" {{{1 Shougo Config
" {{{2 Unite Config
nnoremap <silent> <leader>uf :<C-u>Unite buffer<CR>
nnoremap <silent> <leader>if :<C-u>Unite -start-insert buffer<CR>
nnoremap <silent> <leader>ut :<C-u>Unite tab:no-current<CR>
nnoremap <silent> <leader>it :<C-u>Unite -start-insert tab:no-current<CR>
" }}}
" {{{2 Echodoc
let g:echodoc_enable_at_startup = 1
" }}}
" {{{2 Deoplete
" {{{3 Jedi
let g:jedi#auto_vim_configuration = 0
let g:jedi#force_py_version = 3
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#documentation_command = "K"
let g:jedi#show_call_signatures = "1"

let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#enable_cache = 1
" }}}
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 1
let g:deoplete#enable_smart_case = 1


"   Make tab perform the completion for deoplete
" inoremap <silent><expr> <Tab>
"             \ pumvisible() ? "\<C-n>" :
"             \ deoplete#mappings#manual_complete()
" }}}
" {{{ Neomake
" Automatically run Neomake on write
if !exists('neomake_config_done')
    let g:neomake_config_done = 1
    nnoremap <leader>m :Neomake<CR>

    " Automatically open the error window
    let g:neomake_open_list = 1

    " Python
    let g:neomake_python_flake8_maker = {
            \ 'args': ['--max-line-length=140', '--ignore=E402']
            \ }

    " TODO: Get prospector to work, maybe just on a special command.
    " let g:neomake_python_prospector_maker = {
    "     \ 'exe': 'prospector',
    "     \ 'args': ['%:p'],
    "     \ }
    " let g:neomake_python_enabled_makers = [ 'flake8', 'prospector' ]

    let g:neomake_python_enabled_makers = [ 'flake8' ]

    " Vim
    let g:neomake_vimscript_enabled_makers = [ 'vint' ]

    " Javascript
    let g:neomake_javascript_jshint_maker = {
        \ 'args': ['--verbose'],
        \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
        \ }
    let g:neomake_javascript_enabled_makers = ['jshint']

    " C
    " let g:neomake_c_gcc_maker = {
    " \ }
    " let g:neomake_c_enabled_makers = ['clang-3.6']

    autocmd BufWritePre *.py Neomake
    " autocmd BufWritePre *.vim Neomake
endif
" }}}
" }}}
" {{{ Colorscheme
syntax enable

set cursorline    " Highlight the current line
set termguicolors " Better color support

" Easily switch between color schemes
" let g:current_scheme = 'gruvbox-tj'
let g:current_scheme = 'gruvbox-tj'

if current_scheme == 'gruvbox'
    let g:gruvbox_italic=1              " Turn on italics for gruvbox
    set background=dark

    colorscheme gruvbox
elseif current_scheme == 'gruvbox-tj'
    let g:gruvbox_italic=1              " Turn on italics for gruvbox
    let g:gruvbox_bold=1
    let g:gruvbox_termcolors=256
    " let g:gruvbox_improved_warnings=1
    " let g:gruvbox_improved_strings=1
    let g:gruvbox_contrast_dark='soft'

    set background=dark
    colorscheme gruvbox-tj
elseif current_scheme == 'seoul256'
    " seoul256 (dark):
    "   Range:   233 (darkest) ~ 239 (lightest)
    "   Default: 237
    let g:seoul256_background = 234
    colo seoul256
elseif current_scheme == 'onedark'
    colorscheme onedark

    let g:airline_theme='onedark'
    let g:onedark_terminal_italics=1
elseif current_scheme == 'hybrid'
    " let g:hybrid_custom_term_colors = 1
    let g:hybrid_reduced_contrast = 1
    set background=dark
    colorscheme hybrid
elseif current_scheme == 'base16'
    set background=dark
    let base16colorspace=256
    colorscheme base16-tomorrow
endif

" }}}
" {{{ Airline Configuration
let g:airline_powerline_fonts=1
" let g:airline_section_z = airline#section#create(['%4l', ' :%3v', gutentags#statusline('[Generating...]')]) " Only show the line & col number
let g:airline_section_z = airline#section#create(['%4l', ' :%3v']) " Only show the line & col number

let g:airline_inactive_collapse = 1 " Only indicate filename on inactive buffers
let g:airline_exclude_preview = 1 " Don't show status line in preview
let g:airline#extensions#branch#empty_message = '' " No Branch Message
let g:airline#extensions#branch#format = 2 " See documentation

" Tabline config
let g:airline#extensions#tabline#enabled = 1 " Enable Tabline integration
let g:airline#extensions#tabline#buffer_idx_mode = 1 " Leader # navigation

nmap <leader>1 <Plug>AirlineSelectTab1
" }}}
" {{{ Tagbar Configuration
nnoremap <silent> <C-t> :TagbarToggle<CR>
" }}}
" {{{ Nyaovim Markdown Preview
" Only apply if it is loaded
if exists(':StartMarkdownPreview')
    let g:markdown_preview_auto = 1
    let g:markdown_preview_eager = 1
endif
" }}}
" {{{ Web Development
let g:used_javascript_libs = 'jquery'
" }}}
" {{{ General Mapping
" Easier Moving between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Move easily to the next error
nnoremap <leader>l :lnext<CR>
nnoremap <leader>h :lprevious<CR>

" System clipboard integration!
set clipboard+=unnamedplus
" }}}
" {{{ Terminal Mapping
" Make esc leave terminal mode
tnoremap <Esc> <C-\><C-n>

" Easy moving between the buffers
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" }}}
" {{{ Vim-Startify Configuration
let g:startify_bookmarks = ['~/.zshrc', '~/.config/nvim/.nvimrc']
let g:startify_change_to_dir = 1
let g:startify_list_order = [
  \ ['   LRU:'],
  \ 'files',
  \ ['   LRU within this dir:'],
  \ 'dir',
  \ ['   Sessions:'],
  \ 'sessions',
  \ ['   Bookmarks:'],
  \ 'bookmarks',
  \ ]

let g:startify_skiplist = [
            \ 'COMMIT_EDITMSG',
            \ 'bundle/.*/doc',
            \ '/data/repo/neovim/runtime/doc',
            \ '/Users/mhi/local/vim/share/vim/vim74/doc',
            \ ]

let g:startify_custom_footer =
  \ ['', "   Vim is charityware. Please read ':help uganda'.", '']

hi StartifyBracket ctermfg=240
hi StartifyFile    ctermfg=147
hi StartifyFooter  ctermfg=240
hi StartifyHeader  ctermfg=114
hi StartifyNumber  ctermfg=215
hi StartifyPath    ctermfg=245
hi StartifySlash   ctermfg=240
hi StartifySpecial ctermfg=240
" }}}
" {{{ Hilarious fun screen saver
" Press \r to start rotating lines and <C-c> (Control+c) to stop.

function! s:RotateString(string)
    let split_string = split(a:string, '\zs')
    return join(split_string[-1:] + split_string[:-2], '')
endfunction

function! s:RotateLine(line, leading_whitespace, trailing_whitespace)
    return substitute(
        \ a:line,
        \ '^\(' . a:leading_whitespace . '\)\(.\{-}\)\(' . a:trailing_whitespace . '\)$',
        \ '\=submatch(1) . <SID>RotateString(submatch(2)) . submatch(3)',
        \ ''
    \ )
endfunction

function! s:RotateLines()
    let saved_view = winsaveview()
    let first_visible_line = line('w0')
    let last_visible_line = line('w$')
    let lines = getline(first_visible_line, last_visible_line)
    let leading_whitespace = map(
        \ range(len(lines)),
        \ 'matchstr(lines[v:val], ''^\s*'')'
    \ )
    let trailing_whitespace = map(
        \ range(len(lines)),
        \ 'matchstr(lines[v:val], ''\s*$'')'
    \ )
    try
        while 1 " <C-c> to exit
            let lines = map(
                \ range(len(lines)),
                \ '<SID>RotateLine(lines[v:val], leading_whitespace[v:val], trailing_whitespace[v:val])'
            \ )
            call setline(first_visible_line, lines)
            redraw
            sleep 50m
        endwhile
    finally
        if &modified
            silent undo
        endif
        call winrestview(saved_view)
    endtry
endfunction

nnoremap <silent> <Plug>(RotateLines) :<C-u>call <SID>RotateLines()<CR>

nmap \r <Plug>(RotateLines)

" }}}
" vim:foldmethod=marker:foldlevel=0
