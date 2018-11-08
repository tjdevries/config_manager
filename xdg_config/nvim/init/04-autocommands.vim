" {{{ Braceless Vim
augroup MyBraceless
  au!
  autocmd FileType haml,yaml,coffee BracelessEnable +indent +fold +highlight
  autocmd FileType python BracelessEnable +highlight
augroup END
" }}}


function! s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun

function! s:diff_handle() abort
  echo v:option_new
  if v:option_new == 1
    echo 'Setting nocursorline'
    setlocal nocursorline
  endif

  if v:option_new == 0
    setlocal cursorline
  endif
endfunc

let execute_string = '"call <SNR>' . s:SID() . '_diff_handle()"'
augroup MyDiffHandle
  au!
  execute 'autocmd OptionSet diff execute ' .execute_string
augroup END
