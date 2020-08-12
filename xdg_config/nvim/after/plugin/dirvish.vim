if !get(g:, 'loaded_dirvish', v:false)
  finish
endif

let g:DevIconsArtifactFixChar = '            '
let g:DevIconsAppendArtifactFix = 1

function s:make_map(key, action) abort
  call execute(printf(
        \ "autocmd FileType dirvish nnoremap <silent><buffer> %s :call dirvish#open('%s', 0)<CR>",
        \ a:key,
        \ a:action,
        \ ))
  call execute(printf(
        \ "autocmd FileType dirvish xnoremap <silent><buffer> %s :call dirvish#open('%s', 0)<CR>",
        \ a:key,
        \ a:action,
        \ ))
endfunction

augroup dirvish_config
  au!

  call s:make_map('e', 'edit')
  call s:make_map('t', 'tabedit')
  call s:make_map('v', 'vsplit')
  call s:make_map('s', 'split')

  " TODO: We could use the lua version of this, to make it even faster
  autocmd FileType dirvish 
        \ call dirvish#add_icon_fn(
          \ { p ->  WebDevIconsGetFileTypeSymbol(p, p[-1:] == '/' ? 1 : 0) }
          \ )
augroup END
