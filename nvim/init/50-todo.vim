
if !isdirectory(expand('~/todo'))
  call mkdir(expand('~/todo'))
endif

command! ToDo :vnew ~/todo/current.txt
