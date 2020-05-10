
function! PythonAuto() abort
  if &filetype != 'python'
    return
  endif

  if get(b:, 'nofmt', v:false)
    return
  endif

  let g:auto_python = system("~/.pyenv/shims/python -m pyfixfmt --file-glob " . expand("%:p"))
  edit
endfunction
