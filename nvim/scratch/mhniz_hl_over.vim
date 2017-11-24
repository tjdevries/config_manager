if v:false
  function! ToggleOverLength() abort
    if exists('b:overlength')
      call matchdelete(b:overlength)
      unlet b:overlength
    else
      let b:overlength = matchadd('OverLength', '\%72v.*')
    endif
  endfunction

  autocmd BufEnter * call ToggleOverLength()
  highlight OverLength ctermbg=lightgrey guibg=#8b0000
  nnoremap <leader>t :call ToggleOverLength()<cr>
endif
