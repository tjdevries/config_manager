" if exists('g:_sourced_epic')
"   finish
" endif

let g:_sourced_epic = 1

" call execute('source ' . g:_vimrc_base . '/autoload/epic.vim')

function! PQARealRoutines() abort
  g/^\s\+/:normal! dd
  g/.* q .*/:normal! dd

  sort i

  " Get the routine name at the top
  g/.*; ; ;/normal! ddggP
endfunction

try
  call epic#conf#set('docs', 'initials', 'tjdv')

endtry
