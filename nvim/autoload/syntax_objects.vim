
" for id in synstack(line('.'), col('.'))
"   call add(l:syntax_list, synIDattr(id, 'name'))
" endfor

function! syntax_objects#find_start_group(line, col, group_name)
  return s:search_group(a:line, a:col, a:group_name, -1)
endfunction

function! syntax_objects#find_end_group(line, col, group_name)
  return s:search_group(a:line, a:col, a:group_name, 1)
endfunction

""
" @param direction: +1 for forwards, -1 for backwards
function! s:search_group(line, col, group_name, direction)
  let l:found = v:false

  let l:current_line = a:line
  let l:current_col = a:col

  let l:end_line = a:direction == 1 ? line('$') : 1

  while l:current_line != l:end_line
    let l:end_col = a:direction == 1 ? col([l:current_line, '$']) : 1
    while l:current_col != l:end_col
      let l:syntax_list = map(synstack(l:current_line, l:current_col), 'synIDattr(v:val, "name")')

      if !empty(l:syntax_list)
        if index(l:syntax_list, a:group_name) >= 0
          if !l:found
            let l:found = v:true
          endif
        else
          if l:found
            return [l:current_line, l:current_col]
          endif
        endif
      endif

      let l:current_col = l:current_col + a:direction
    endwhile

    let l:current_line = l:current_line + a:direction
    let l:current_col = a:direction == 1 ? 1 : col([l:current_line, '$'])
  endwhile

  return [-1, -1]
endfunction

nnoremap <leader>te :echo syntax_objects#find_end_group(line('.'), col('.'), 'cType')<CR>
nnoremap <leader>pe :echo syntax_objects#find_start_group(line('.'), col('.'), 'cType')<CR>
nnoremap <leader>to :echo syntax_objects#find_end_group(line('.'), col('.'), 'cOperator')<CR>
nnoremap <leader>po :echo syntax_objects#find_start_group(line('.'), col('.'), 'cOperator')<CR>
