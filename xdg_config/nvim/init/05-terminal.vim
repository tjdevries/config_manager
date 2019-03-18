
function! s:small_terminal() abort
  new
  wincmd J
  call nvim_win_set_height(0, 12)
  term
endfunction

nnoremap <leader>st :call <SID>small_terminal()<CR>
