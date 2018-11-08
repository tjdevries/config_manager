function! TestStuff() abort
  normal! gg

  let g:res = []

  while search('^\S', 'W')
    call insert(g:res, {
            \ 'name': expand('<cword>'),
            \ 'line': line('.'),
            \ },
          \ len(g:res)
          \ )
  endwhile

  normal! gg

  let index = 0
  while search('^\s*links to', 'W')
    while index < (len(g:res) - 1)
      if line('.') > g:res[index].line && line('.') < g:res[index + 1].line
        let g:res[index].link = matchlist(getline('.'), '\(\s*links to \)\(.*\)')[2]
        break
      endif

      let index = index + 1
    endwhile

    if index == len(g:res) - 1
      let g:res[index].link = matchlist(getline('.'), '\(\s*links to \)\(.*\)')[2]
    endif
  endwhile


  return g:res
endfunction
