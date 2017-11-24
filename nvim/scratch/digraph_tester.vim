

function! TestDigraph(c1, c2) abort
  let char_1 = nr2char(a:c1)
  let char_2 = nr2char(a:c2)
  call nvim_input(":let g:__temp_var = '\<c-k>" . char_1 . char_2 . "'<CR>")
  call nvim_input('i' . g:__temp_var)
  unlet g:__temp_var
endfunction
