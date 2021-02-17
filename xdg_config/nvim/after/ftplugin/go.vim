" Folding Methods for Go {{{

" We wrote this on stream one time to help someone.
" I don't really know if it's good or not.

function! s:matches(str, patterns) abort
  if type(a:patterns) == v:t_string
    return match(a:str, a:patterns) != -1
  elseif type(a:patterns) == v:t_list
    for pat in a:patterns
      if s:matches(a:str, pat)
        return v:true
      endif
    endfor
  endif

  return v:false
endfunction

let s:start_new_important_fold = [
          \ '^func',
          \ '^struct',
          \ ]

let s:is_comment =  '^//\ '

function! GoFolder(...) abort
  let lnum = get(a:, 1, v:lnum)
  let line = getline(lnum)

  let next_line = getline(lnum + 1)
  let prev_line = getline(lnum - 1)

  " TOD0: Copy some basics from vim go...

  if s:matches(line, s:is_comment)
    " Start a new fold when the previous line was empty
    if s:matches(prev_line, '^$')
      return ">1"
    endif

    " Stop the current fold when the next line is important
    if s:matches(next_line, s:start_new_important_fold)
      return "<1"
    endif

    " Otherwise you're chillin in the fold
    return "1"
  endif

  if s:matches(line, s:start_new_important_fold)
    return ">1"
  endif

  return "="
endfunction

function! GoText(...) abort
  let fold_start = get(a:, 1, v:foldstart)
  let fold_end = get(a:, 2, v:foldend)

  let start_line = getline(fold_start)

  if s:matches(start_line, s:is_comment)
    let lines = getline(fold_start, fold_end)

    " TODO: Limit how many characters we see.
    " Pick out only the stuff I want fro mcmoments
    return join(
          \ map(lines, { k, v -> substitute(v, '// ', '', '') }),
          \ " ")
  endif

  " TODO: Still could make structs and funcs show up cooler...
  " etc.
  return foldtext()
endfunction

setlocal foldmethod=expr
setlocal foldexpr=GoFolder()
setlocal foldtext=GoText()
setlocal foldlevel=1
" }}}

setlocal noexpandtab
