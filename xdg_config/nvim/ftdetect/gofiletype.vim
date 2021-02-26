"
" vim-go/ftdetect/gofiletype.vim
"

" Note: should not use augroup in ftdetect (see :help ftdetect)
au BufRead,BufNewFile *.go setfiletype go
au BufRead,BufNewFile *.s setfiletype asm
au BufRead,BufNewFile *.tmpl setfiletype gohtmltmpl
au BufRead,BufNewFile go.sum set filetype=gosum

" remove the autocommands for modsim3, and lprolog files so that their
" highlight groups, syntax, etc. will not be loaded. *.MOD is included, so
" that on case insensitive file systems the module2 autocmds will not be
" executed.
au! BufRead,BufNewFile *.mod,*.MOD
" Set the filetype if the first non-comment and non-blank line starts with
" 'module <path>'.
au BufRead,BufNewFile go.mod call s:gomod()

fun! s:gomod()
  for l:i in range(1, line('$'))
    let l:l = getline(l:i)
    if l:l ==# '' || l:l[:1] ==# '//'
      continue
    endif

    if l:l =~# '^module .\+'
      setfiletype gomod
    endif

    break
  endfor
endfun
