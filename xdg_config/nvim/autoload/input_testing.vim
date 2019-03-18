function! input_testing#example()
  echo 'hello world'
  " return ',en'
endfunction

nmap <expr> <space> input_testing#example()

function! s:execute(cmd) abort
  if exists('*execute')
    return split(execute(a:cmd), "\n")
  endif
endfunction

