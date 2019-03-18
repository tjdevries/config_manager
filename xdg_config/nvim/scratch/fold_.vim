let s:label_match = '^\%[%]\w\+'
let s:comment_match = '^\s\+;'

function! MFoldText(...) abort
  let start = get(a:000, 0, v:foldstart)
  let end = get(a:000, 1, v:foldend)

  let fold_lines = getline(start, end)

  let text = '____/ '

  let name = s:get_name(fold_lines)
  if name != ''
    let text .= '[' . name . '] '
  endif

  let scope = s:get_scope(fold_lines)
  if scope != ''
    let padding = 40 - len(text)
    let text .= repeat(' ', padding) . 'S: ' . s:get_scope(fold_lines)
  endif

  let padding = 80 - len(text)
  let text .= repeat(' ', padding) . ' \' . repeat('_', 200)

  return text
endfunction

function! s:get_scope(lines) abort
  for line in a:lines
    let scope = matchlist(line, 'SCOPE: \(\w*\)')[1]

    if scope != ""
      break
    endif

  endfor

  return scope
endfunction

function! s:get_name(lines) abort
  for line in a:lines
    let name = matchstr(line, s:label_match)

    if name != ""
      break
    endif
  endfor

  return name
endfunction

function! MFoldExpr(line_number) abort
  let lnum = a:line_number

  if lnum == 1
    return '>1'
  endif

  if lnum == line('$')
    return '<1'
  endif

  let line = getline(lnum)

  " If it's a label, it's a 1
  if match(line, s:label_match) != -1
    return '1'
  endif

  let next_line_number = lnum + 1
  let next_line = getline(next_line_number)

  let prev_line_number = lnum -1
  let prev_line = getline(prev_line_number)

  " If we're not a comment, and the next line is a label, we finish 1
  if match(line, s:comment_match) == -1
    if match(next_line, s:label_match) != -1
      return '<1'
    endif

    return 1
  endif

  " Check if we're in a comments
  if match(line, s:comment_match) != -1
    let first_comment = (match(prev_line, s:comment_match) == -1)

    if !first_comment
      return 1
    endif

    while v:true
      let next_line = getline(next_line_number)
      " IF the next line is a label,
      " then this is the end of a level 1 fold
      if match(next_line, s:label_match) != -1
        return '>1'
      endif

      " If the next line is NOT a comment
      " and also not a label
      " Then it should be part of the last fold
      if match(next_line, s:comment_match) == -1
        return 1
      endif

      let next_line_number += 1
    endwhile
  endif

  if match(line, s:comment_match) != -1
    return 1
  endif

  return 1
endfunction
