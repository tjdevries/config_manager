function! DiffSetup() abort
  if v:option_new == 1
    setlocal nocursorline
  endif

  if v:option_new == 0
    setlocal cursorline
  endif
endfunc

augroup MyDiffHandle
  au!
  autocmd OptionSet diff call DiffSetup()
augroup END
