
let g:vista_default_executive = 'nvim_lsp'

let g:vista_echo_cursor_strategy = 'floating_win'

" ANKI: Search for objects within the current file with Vista
nnoremap <space>vd <cmd>Vista finder fzf:nvim_lsp<CR>

" ANKI: Toggle Vista window
nnoremap <space>vv <cmd>Vista!!<CR>



" TODO: Get the floating preview stuff working correctly
