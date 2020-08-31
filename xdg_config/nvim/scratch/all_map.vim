function! AllMap(lhs, rhs) abort
  execute 'nnoremap ' . a:lhs . ' ' . a:rhs
  execute 'vnoremap ' . a:lhs . ' ' . a:rhs
  execute 'inoremap ' . a:lhs . ' ' . a:rhs

  " etc.
endfunction

call AllMap('<up>', '<nop>')
