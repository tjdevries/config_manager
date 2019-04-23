

nnoremap <leader><leader>f :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(expand("<cword>")), 1, 0)<CR>

nnoremap <leader><leader>F :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(expand("<cWORD>")), 1, 0)<CR>


nnoremap <leader>test :call fzf#run({'source': 'rg --files', 'sink': 'vnew', 'dir': expand('~/sourceress/web/tests/')})<CR>

" TODO: This doesn't seem to do anything
nnoremap <leader>stest :call fzf#run({'source': 'rg', 'sink': 'vnew', 'dir': expand('~/sourceress/web/tests/')})<CR>
