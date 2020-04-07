
function! PythonAuto() abort
  if &filetype != 'python'
    return
  endif

  call execute("!python -m pyfixfmt --file-glob " . expand("%:p"))
  edit
endfunction
