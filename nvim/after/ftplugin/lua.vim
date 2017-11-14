

setlocal foldmethod=expr
setlocal foldexpr=LuaFoldExpr(v:lnum)
setlocal foldtext=LuaFoldText()
setlocal fillchars=fold:\ 


let s:object_start = '^local \S* = {}'
let s:object_property_start = '^\S*\.\S* = function('

let s:local_function = '^local \S* = function('

let s:file_return = '^return'


function! s:matches(line, expr) abort
  return match(a:line, a:expr) != -1
endfunction

function! LuaFoldExpr(line_number) abort
  let lnum = a:line_number
  let line = getline(lnum)

  if lnum == 1
    return ">1"
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


  return getline(start)
endfunction
