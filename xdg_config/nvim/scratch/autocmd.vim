let g:my_var = v:true

autocmd BufEnter * while g:my_var
autocmd BufEnter *   echo 'hello'
autocmd BufEnter *   let g:my_var = v:false
autocmd BufEnter * endwhile



