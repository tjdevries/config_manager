
let g:highlight_overlength = v:true
let g:highlight_overlength_length = 72

" Use :call ToggleOverlength()
" to toggle whether or not you show highlights
function! ToggleOverlength() abort
  let g:highlight_overlength = !g:highlight_overlength

  if g:highlight_overlength
    call s:add_highlights()
  else
    call ClearOverlength()
  endif
endfunction

" Use :call ClearOverlength()
" to just clear the current highlights
" They will probably show up again when you enter the buffer again though.
function! ClearOverlength() abort
  if exists('b:last_overlength')
    " Just try and delete it
    " Don't worry if it messes up
    try
      call matchdelete(b:last_overlength)
    catch
    endtry
    unlet b:last_overlength
  endif
endfunction


function! s:add_highlights() abort
  call ClearOverlength()

  if g:highlight_overlength
    if !exists('b:last_overlength')
      let b:last_overlength = matchadd('OverLength', '\%' . g:highlight_overlength_length . 'v.*')
    endif
  endif
endfunction


augroup vimrc_autocmds
  au!
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#8b0000
  autocmd BufEnter * call <SID>add_highlights()
augroup END
