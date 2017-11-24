

setlocal foldmethod=expr
setlocal foldexpr=LuaFoldExpr(v:lnum)
setlocal foldtext=LuaFoldText()
setlocal fillchars=fold:\ 



" TODO: Handle nested describes?...
let s:test_start = '^describe('
let s:test_case_start = '^\s*it('

let s:object_start = '^local \S* = {}'
let s:object_property_start = '^\S*\.\S* = function('

let s:local_function = '^local \S* = function('

let s:file_return = '^return'


function! s:matches(line, expr) abort
  return match(a:line, a:expr) != -1
endfunction

function! s:comment_level(line) abort
  let g:comment_line[a:line] = str2nr(matchlist(a:line, '^\s*--\(\d*\)')[1])
  return str2nr(matchlist(a:line, '^\s*--\(\d*\)')[1])
endfunction

function! LuaFoldExpr(line_number) abort
  let lnum = a:line_number
  let line = getline(lnum)

  if lnum == 1
    return ">1"
  endif

  if s:comment_level(line) > 0
    return ">" . s:comment_level(line)
  endif

  if s:matches(line, s:object_start)
    return ">1"
  endif

  if s:matches(line, s:object_property_start)
    return ">2"
  endif

  if s:matches(line, s:file_return)
    return ">1"
  endif

  if s:matches(line, s:local_function)
    return ">2"
  endif

  if s:matches(line, '^end$')
    return "s1"
  endif

  " *_spec.lua folders
  if s:matches(line, s:test_start)
    return ">1"
  endif

  if s:matches(line, s:test_case_start)
    return ">2"
  endif

  if s:matches(line, '^\s*end)$')
    return "s1"
  endif

  if s:matches(line, '^\s*before_each')
    return "a1"
  endif

  return "="
endfunction

function! s:is_self_function(line)
  if s:matches(a:line, 'self')
    return v:true
  end

  return v:false
endfunction

function! LuaFoldText(...) abort
  let start = get(a:000, 0, v:foldstart)
  let end = get(a:000, 1, v:foldend)

  let start_line = getline(start)

  if start == 1 && s:matches(start_line, 'require')
    return '-- Includes'
  endif

  if v:foldlevel == 1 && s:matches(start_line, s:object_start)
    return printf('Object: %s', split(start_line, ' ')[1])
  endif

  if v:foldlevel == 2 && s:matches(start_line, s:object_property_start)
    let object = split(start_line, '\.')[0]
    let name = split(split(start_line, '\.')[1], ' ')[0]
    let args = split(split(start_line, 'function(')[1], ' return')[0]

    let self_function = s:is_self_function(start_line)
    let prefix = self_function ? '' : 'static'
    let scope = s:matches(start_line, '^\S*\._') ? 'private' : 'public'
    let separator = self_function ? ':' : '.'

    return printf('―→ %7s %-8s %s%s%-25s (%s', prefix, scope, object, separator, name, args)
  endif

  if s:matches(start_line, '^\s*--')
    return repeat('  ', v:foldlevel) . substitute(start_line, '^\s*--', '', '')
  endif


  return getline(start)
endfunction
