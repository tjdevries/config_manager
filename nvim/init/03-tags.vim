set tags=tags; " Enable ctags

" Tags navigation {{{
" Tag Go
nnoremap <leader>tg <C-]>
" Tag declaration, next, prev, menu
nnoremap <leader>td 3<C-]>
nnoremap <leader>tn :call tj#tag_mover('next')<CR>
nnoremap <leader>tp :call tj#tag_mover('previous')<CR>
nnoremap <leader>tm :tselect<CR>
" Tag window
nnoremap <leader>tw <C-w><C-]>
nnoremap <leader>ts <C-w><C-]><C-w>H
" Tag tab
nnoremap <leader>tt <C-w><C-]><C-w>T
" }}}

if g:my_tags_manager ==? 'gutentags'
    " No config
elseif g:my_tags_manager ==? 'vim-tags'
    " No config
elseif g:my_tags_manager ==? 'easytags'
    let g:easytags_file = '~/.cache/tags'
    let g:easytags_async = 1    " Background support for easy tags
    let g:easytags_event = ['BufWritePost'] " Update the tags after writing
else
    echoerr "You've set your tags manager to something new"
endif
