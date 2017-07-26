let s:force_jokes = v:true
function! jokes#random_tabstop()
  if !&tabstop || s:force_jokes
    py3 import random; vim.command("let g:random_number = " + str(random.randint(1,12)))
    call execute('set tabstop=' . g:random_number)
  endif
  return "\<tab>"
endfunction

" Really mess with someone when they press tab
" inoremap <expr> <tab> jokes#random_tabstop()


""
" randomly leave insert mode after a few seconds
function! jokes#random_normal() abort
  if exists('*RandomNumber')
    let time_limit = RandomNumber(5, 10)
  else
    let time_limit = 5
  endif

  call timer_start(time_limit, {-> execute('normal! <esc>')})
endfunction
" noremap i :call jokes#random_normal()<CR>i

