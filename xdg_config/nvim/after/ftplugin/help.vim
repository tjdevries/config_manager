" TODO(stream): We chould turn this into a plugin to make writing vim help
" text easier. There's a lot of stuff that would be nice for it.

setlocal expandtab
setlocal textwidth=78
setlocal tabstop=4
setlocal shiftwidth=4


" TODO: When refactoring this, consider just using `:right`...
"       That seems much simpler and better.
function! s:right_align() abort
  let text = matchstr(getline('.'), '^\s*\zs.\+\ze\s*$')
  let remainder = (&l:textwidth + 2) - len(text)
  call setline(line('.'), repeat(' ', remainder).text)
  undojoin
endfunction

function! HelpFormatExpr() abort
  if mode() ==# 'i' || v:char != ''
    return 1
  endif

  let line = getline(v:lnum)
  if line =~# '^=\+$'
    normal! macc
    normal! 78i=
    normal! `a
    undojoin
    return
  elseif line =~# '^\k\%(\k\|\s\)\+\s*\*\%(\k\|-\)\+\*\s*'
    let [header, link] = split(line, '^\k\%(\k\|\s\)\+\zs\s*')
    let header = substitute(header, '^\_s*\|\_s*$', '', 'g')
    let remainder = (&l:textwidth + 1) - len(header) - len(link)
    let line = header.repeat(' ', remainder).link
    call setline(v:lnum, line)
    return
  endif

  return 1
endfunction

if !exists('*<SID>toggle_help_file_type')
  function! s:toggle_help_file_type()
      if &filetype == 'help'
          set filetype=
          setlocal list
          setlocal listchars=tab:>~
          setlocal colorcolumn=78
      else
          set filetype=help
          setlocal nolist
          setlocal colorcolumn=
      endif
  endfunction
endif

nnoremap <silent><buffer> <leader>th :<c-u>call <SID>toggle_help_file_type()<CR>


" [h]elp [a]lign.
nnoremap <silent><buffer> <leader>ha :<c-u>call <sid>right_align()<cr>

nnoremap <silent><buffer> <leader>i= i==============================================================================<esc>
"
" nnoremap <silent><buffer> <leader>

setlocal formatexpr=HelpFormatExpr()
