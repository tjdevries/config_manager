function! LoginMatrix() abort
  let g:matrix_user = input('user: ')
  let g:matrix_passwd = input('pass: ')
  let g:matrix_room = "#neovim:matrix.org"
  MatrixConnect
endfunction


