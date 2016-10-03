" General configuration
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 1
let g:deoplete#enable_smart_case = 1

" Github configuration {{{
let g:deoplete#sources = {}
let g:deoplete#sources.gitcommit=['github']

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.gitcommit = '.+'

let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.gitcommit = '.+'
" call deoplete#util#set_pattern(
"   \ g:deoplete#omni#input_patterns,
"   \ 'gitcommit', [g:deoplete#keyword_patterns.gitcommit])
" }}}
" Jedi configuration {{{
let g:jedi#auto_vim_configuration = 0
let g:jedi#force_py_version = 3
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = '<leader>d'
let g:jedi#goto_assignments_command = '<leader>g'
let g:jedi#documentation_command = 'K'
let g:jedi#show_call_signatures = '1'

let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#enable_cache = 1
let g:deoplete#sources#jedi#worker_threads = 2
" }}}
" Lua configuration {{{
let g:lua_check_syntax = 0
let g:lua_complete_omni = 0
let g:lua_complete_dynamic = 0
let g:lua_define_completion_mappings = 0

" let g:deoplete#omni#functions = get(g:, 'deoplete#omni#functions', {})
" let g:deoplete#omni#functions.lua = 'xolox#lua#omnifunc'
" }}}
" C family configuration {{{
let g:deoplete#sources#clang#libclang_path = '/usr/lib/x86_64-linux-gnu/libclang.so.1'
let g:deoplete#sources#clang#clang_header = '/usr/include/clang/3.4/include/'
" }}}
