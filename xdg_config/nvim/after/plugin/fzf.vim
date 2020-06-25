

nnoremap <leader><leader>f :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(expand("<cword>")), 1, 0)<CR>
nnoremap <leader><leader>F :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(expand("<cWORD>")), 1, 0)<CR>

" ANKI: Call FZF Preview Project Files
nnoremap <space>ff      <cmd>FzfPreviewProjectFiles<CR>
" ANKI: Call FZF Preview Buffers
nnoremap <space>if      <cmd>FzfPreviewBuffers<CR>
" ANKI: Call FZF Preview Git Status
nnoremap <space>gs      <cmd>FzfPreviewGitStatus<CR>
" ANKI: Call FZF Preview Project Grep
nnoremap <space>gg      :FzfPreviewProjectGrep 
" ANKI: Call FZF Preview on current word
nnoremap <space>gw      <cmd>call execute(':FzfPreviewProjectGrep ' . expand("<cword>"))<CR>
" ANKI: Call FZF Preview Tons of Things
nnoremap <space><space> <cmd>FzfPreviewFromResources project git directory buffer project_mru<CR>

nnoremap <leader>en     <cmd>FzfPreviewDirectoryFiles ~/.config/nvim<CR>
