
let g:plugin_path = expand('~/.config/vim_plug')

let g:builtin_lsp = v:true
let g:my_deoplete_enabled = v:false
let g:my_snippet_manager = 'ultisnips'

let g:demo = v:true

call plug#begin(g:plugin_path)


Plug 'tjdevries/conf.vim'
Plug 'tjdevries/standard.vim'

Plug 'tjdevries/colorbuddy.vim'
Plug 'norcalli/nvim-colorizer.lua'

" Local Plugins{{{
function! s:local_plug(package_name) abort 
  if isdirectory(expand("~/plugins/" . a:package_name))
    execute "Plug '~/plugins/".a:package_name."'"
  else
    execute "Plug 'tjdevries/" .a:package_name."'"
  endif
endfunction

call s:local_plug('colorbuddy.vim')
call s:local_plug('gruvbuddy.nvim')

call s:local_plug('cyclist.vim')

call s:local_plug('luvjob.nvim')
call s:local_plug('plenary.nvim')
call s:local_plug('apyrori.nvim')
call s:local_plug('py_package.nvim')
" call s:local_plug('manillua.nvim')

" }}}
" LSP {{{

" Yo, we got lsp now
Plug 'neovim/nvim-lsp'

Plug 'haorenW1025/completion-nvim'
Plug 'haorenW1025/diagnostic-nvim'
Plug 'wbthomason/lsp-status.nvim'

" Cool tags based viewer
Plug 'liuchengxu/vista.vim'

" Debug adapter protocol
Plug 'puremourning/vimspector'

" }}}

Plug 'tweekmonster/haunted.vim'

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

call plug#end()

set completeopt=menuone,noinsert,noselect

lua require('colorbuddy').colorscheme('gruvbuddy')
lua require('lsp_config')

" Quit quickly and easily
nnoremap <C-D> :qa!<CR>
inoremap <C-D> <c-o>:qa!<CR>
