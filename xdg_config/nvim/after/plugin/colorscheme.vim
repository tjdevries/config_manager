scriptencoding utf-8

" {{{ Halo
" Thanks to Justinmk for this.
" Not currently using it though. I want to change some of the colors to make
" it work my colorschemes more. And maybe have it wait until multiple presses.
let g:halo_enabled = v:false

if g:halo_enabled == v:true
  highlight Halo guibg=#F92672 ctermbg=197
  let g:halo = {}
  function! s:halo_clear(id) abort
    silent! call timer_stop(g:halo['timer_id'])
    silent! call matchdelete(g:halo['hl_id'])
  endfunction
  function! s:halo() abort
    call s:halo_clear(-1)
    let g:halo['hl_id'] = matchaddpos('Halo',
          \[[line('.'),   col('.')-10, 20],
          \ [line('.')-1, col('.')-10, 20],
          \ [line('.')-2, col('.')-10, 20],
          \ [line('.')+1, col('.')-10, 20],
          \ [line('.')+2, col('.')-10, 20]]
          \)
    let g:halo['timer_id'] = timer_start(1000, function('s:halo_clear'))
  endfunction
  augroup halo_plugin
    autocmd!
    autocmd WinLeave * call <SID>halo_clear(-1)
  augroup END
  nnoremap <silent> <Esc> :call <SID>halo()<CR>
endif
" }}}


" TODO: I would really like to be able to show the highlights from whatever
" highlight is being applied by `nvim_buf_add_highlight` here as well. It is
" not currently possible, as far as I know.
"
" Waiting for @bfredl to fix for me :grin:
function! NewSyntaxNames() abort
  let l:syntax_list = []
  for id in synstack(line('.'), col('.'))
    call add(l:syntax_list, synIDattr(synIDtrans(id), 'name'))
  endfor

  return l:syntax_list
endfunction

" Syntax help
nnoremap <leader>sh :echo string(NewSyntaxNames())<CR>
