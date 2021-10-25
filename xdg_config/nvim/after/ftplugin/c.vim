setlocal shiftwidth=2
setlocal commentstring=//%s

setlocal formatoptions-=o

if !empty(findfile('src/uncrustify.cfg', ';'))
  setlocal formatprg=uncrustify\ -q\ -l\ C\ -c\ src/uncrustify.cfg\ --no-backup\ 2>/dev/null

  "" augroup Uncrustify
  ""   au! <buffer>
  ""   autocmd BufWritePre <buffer> :
  "" augroup END
endif
