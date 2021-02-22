" This is sad hack to get tree sitter to respect me just wanting to run MY OWN
" FILES?!?!?!?!
"
" WHY DOES THAT HAVE TO BE HARD @VIGOUX?!?!

function! SetSyntax(ft)
  if a:ft == 'rust'
    return
  endif

  exe 'set syntax=' . a:ft
endfunction

au! syntaxset
augroup syntaxset
  au! FileType * call SetSyntax(expand("<amatch>"))
augroup END
