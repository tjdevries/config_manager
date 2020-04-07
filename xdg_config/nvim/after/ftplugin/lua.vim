if isdirectory(expand('~/plugins/manillua.nvim/'))
  finish
endif

setlocal foldmethod=expr
setlocal foldexpr=LuaFoldExpr(v:lnum)
setlocal foldtext=LuaFoldText()
setlocal fillchars=fold:\ 

" TODO: Add some highlighting of metamethods

" TODO: Handle nested describes?...
let s:test_start = '^describe('
let s:nested_test_start = '^\s\+describe('
let s:test_case_start = '^\s*it('

let s:object_start = '^local \S* = {}'
let s:object_property_start = '^\S*\.\S* = function(\|^function \S*\.\S*('
let s:docstring_start = '^---'

let s:local_function = '^local \S* = function('

let s:file_return = '^return'


function! s:matches(line, expr) abort
  if type(a:expr) == v:t_string
    return match(a:line, a:expr) != -1
  elseif type(a:expr) == v:t_list
    return len(filter(copy(a:expr), {idx, val -> s:matches(line, val)})) > 0
  endif
endfunction

function! s:comment_level(line) abort
  let result = matchlist(a:line, '^\s*--\(\d*\)')
  return len(result) > 0 ? str2nr(result[1]) : 0
endfunction

function! LuaFoldExpr(line_number) abort
  let lnum = a:line_number
  let line = getline(lnum)

  " TODO: Better 'import' catching and maybe make it level 2
  if lnum == 1
    return ">1"
  endif

  let previous_line = getline(lnum - 1)
  let next_line = getline(lnum + 1)

  if s:matches(line, '^--\W*\d')
    return '>' . matchstr(line, '\d')
  endif


  "" Comment Handling
  if s:comment_level(line) > 0
    return ">" . s:comment_level(line)
  endif


  if s:matches(line, s:local_function)
    return ">2"
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

  if s:matches(start_line, s:object_property_start)
    call add(g:lua_folds, start_line)

    if s:matches(start_line, '^function')
      let important = matchlist(start_line, '^function \(.*\)(')[1]
      let object = split(important, '\.')[0]
      let name = split(important, '\.')[1]
      let args = "...)"
    else
      let object = split(start_line, '\.')[0]
      let name = join(split(split(start_line, ' ')[0], '\.')[1:], '.')
      let args = split(split(start_line, 'function(')[1], ' return')[0]
    endif

    let self_function = s:is_self_function(start_line)
    let prefix = self_function ? '' : 'static'
    let scope = s:matches(start_line, '^\S*\._') ? 'private' : 'public'
    let separator = self_function ? ':' : '.'

    return printf('―→ %7s %-8s %s%s%-25s (%s', prefix, scope, object, separator, name, args)
  endif

  if s:matches(start_line, '^---')
    return '===== ' . strpart(start_line, 4) . ' ====='
  endif

  if s:matches(start_line, '^\s*--')
    return repeat('  ', v:foldlevel) . substitute(start_line, '^\s*--', '', '')
  endif

  if s:matches(start_line, s:test_start) || s:matches(start_line, s:nested_test_start)
    let briefcase = std#os#has_windows() ? '[]' : '🗄'
    let match_list = matchlist(tr(start_line, "'", '"'), 'describe("\(.*\)"')
    return len(match_list) > 0 ?
          \ printf('%s%s Describe => %s', repeat(' ', v:foldlevel), briefcase, match_list[1])
          \ : start_line
  endif

  if s:matches(start_line, s:test_case_start)
    let emoji_character = std#os#has_windows() ? '>>' : '💼'
    let match_list = matchlist(tr(start_line, "'", '"'), 'it("\(.*\)"')
    return len(match_list) > 0 ?
          \ printf('%s%s It %s', repeat(' ', v:foldlevel), emoji_character, match_list[1])
          \ : start_line
  endif


  return getline(start)
endfunction
