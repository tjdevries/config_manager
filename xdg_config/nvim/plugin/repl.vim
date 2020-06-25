
if v:false 
  nnoremap <leader>dm :call repl#_django_get_model()<CR>
  nnoremap <leader>dj :call repl#_django_obj_json()<CR>

  nnoremap <leader>sl :call repl#send_line(repl#_find_repl())<CR>
  nnoremap <leader>sa :call repl#send_all(repl#_find_repl())<CR>
endif
