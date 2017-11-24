
let s:my_var = {}

function! s:my_var.something() abort dict
  let l:self.key = 42
endfunction

call s:my_var.something()
echo s:my_var.key
