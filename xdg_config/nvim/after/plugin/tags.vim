set tags=tags; " Enable ctags

" Tags navigation {{{
"
" Tag Go
nnoremap <leader>tg <C-]>
" Tag declaration, next, prev, menu
nnoremap <leader>tn :call tj#tag_mover('next')<CR>
nnoremap <leader>tp :call tj#tag_mover('previous')<CR>
nnoremap <leader>tm :tselect<CR>
" Tag window
nnoremap <leader>tw <C-w><C-]>
nnoremap <leader>ts <C-w><C-]><C-w>H
" Tag tab
nnoremap <leader>tt <C-w><C-]><C-w>T
" Tag bar, if available
if exists(':TagbarToggle')
    nnoremap <silent> <leader>tb :TagbarToggle<CR>
endif
" }}}

let g:loaded_gentags#gtags = v:true

let g:gen_tags#ctags_prune = v:false
let g:gen_tags#ctags_opts = ['--exclude=.mypy', '--exclude=node_modules', '--exclude=scratches']

let g:vista_ctags_cmd = {
            \ 'python': 'ctags --exclude=.mypy --exclude=node_modules'
            \ }
