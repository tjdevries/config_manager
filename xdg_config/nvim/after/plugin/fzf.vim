

nnoremap <leader><leader>f :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(expand("<cword>")), 1, 0)<CR>
nnoremap <leader><leader>F :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(expand("<cWORD>")), 1, 0)<CR>


" Other helpful shortcuts:
"   To scroll the file, you can use <c-d> and <c-u>. This scrolls in the
"   preview window.
"
"   To negate something, you can use "!" at the beginning of the pattern.
"   To search from beginning, you can use "^" (converse is "$")
"   To exact match, you can use "'"


" ANKI: Call Buffer stuff
nnoremap <space>fb      <cmd>Buffers<CR>
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

" ANKI: Call Fzf Preview File Plugins
nnoremap <space>fp      <cmd>FzfPreviewDirectoryFiles ~/plugins/<CR>

" ANKI: Call Fzf Preview on all plugins.
nnoremap <space>fa      <cmd>FzfPreviewDirectoryFiles ~/.config/vim_plug/<CR>

nnoremap <leader>en     <cmd>FzfPreviewDirectoryFiles ~/.config/nvim<CR>
