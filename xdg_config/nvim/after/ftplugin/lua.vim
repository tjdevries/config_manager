nnoremap <buffer> gf <cmd>:lua require('find_require').find_require()<CR>

setlocal shiftwidth=2

if isdirectory(expand('~/plugins/manillua.nvim/'))
  finish
endif

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
