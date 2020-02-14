if !g:builtin_lsp
  " Should probably find a way to link this if we have coc.nvim?...
  augroup DisableDeoplete
    au!
    for ft in ['python', 'lua', 'json']
      call execute(printf('autocmd FileType %s let b:deoplete_disable_auto_complete = 1', ft))
    endfor
  augroup END
endif

" General configuration
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 1
let g:deoplete#enable_smart_case = 1

" Github configuration {{{
let g:deoplete#sources = {}
let g:deoplete#sources.gitcommit = ['github']

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
let s:libclang_path = '/usr/lib/x86_64-linux-gnu/libclang.so.1'
if filereadable(s:libclang_path)
  let g:deoplete#sources#clang#libclang_path = s:libclang_path
endif

let s:clang_header = '/usr/include/clang/3.4/include/'
if filereadable(s:clang_header)
  let g:deoplete#sources#clang#clang_header = s:clang_header
endif
" }}}
" Rust configuration {{{
if executable('racer')
  " TODO: Handle windows
  let g:deoplete#sources#rust#racer_binary = systemlist('which racer')[0]

  if executable('rustc')
    " if src installed via rustup, we can get it by running
    " rustc --print sysroot then appending the rest of the path
    let rustc_root = systemlist('rustc --print sysroot')[0]
    let rustc_src_dir = rustc_root . '/lib/rustlib/src/rust/src'
    if isdirectory(rustc_src_dir)
      let g:deoplete#sources#rust#rust_source_path = rustc_src_dir
    elseif isdirectory(expand('~/git/rust/src/'))
      let g:deoplete#sources#rust#rust_source_path = expand('~/git/rust/src/')
    endif
  endif
endif
" }}}
