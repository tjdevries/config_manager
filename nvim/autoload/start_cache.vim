
let s:file_name = '~/.local/share/nvim/shada/start_cache.mpack'

let s:cached_values = {}
try
  let s:cached_values = msgpackparse(readfile(expand(s:file_name), 'b'))[0]
catch
endtry

let s:initialized = v:false

function! start_cache#initialize() abort
  let s:initialized = v:true

  augroup StartCache
    au!
    autocmd VimLeavePre call start_cache#vim_leave()
  augroup END
endfunction

""
" cache
function! start_cache#cache(key, F) abort
  let s:cached_values[a:key] = a:F()

  return s:cached_values[a:key]
endfunction

""
" get()
function! start_cache#system(key, cmd) abort
  if has_key(s:cached_values, a:key)
    return s:cached_values[a:key]
  endif

  return start_cache#cache(a:key, { -> systemlist(a:cmd)[0] })
endfunction

""
" Return all the cached values
function! start_cache#copy() abort
  return deepcopy(s:cached_values)
endfunction

function! start_cache#clear() abort
  let s:cached_values = {}
endfunction

function! start_cache#vim_leave() abort
  call writefile([s:cached_values], s:file_name, 'b')
endfunction
