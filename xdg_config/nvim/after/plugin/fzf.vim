

nnoremap <leader><leader>f :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(expand("<cword>")), 1, 0)<CR>
nnoremap <leader><leader>F :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(expand("<cWORD>")), 1, 0)<CR>


" Other helpful shortcuts:
"   To scroll the file, you can use <c-d> and <c-u>. This scrolls in the
"   preview window.
"
"   To negate something, you can use "!" at the beginning of the pattern.
"   To search from beginning, you can use "^" (converse is "$")
"   To exact match, you can use "'"

let g:fzf_preview_use_dev_icons = 1

" ANKI: Call Buffer stuff
" ANKI: Call FZF Preview Project Files
nnoremap <space>ff      <cmd>FzfPreviewProjectFiles<CR>
" ANKI: Call FZF Preview Buffers
nnoremap <space>if      <cmd>FzfPreviewBuffers<CR>
" ANKI: Call FZF Preview Git Status
nnoremap <space>gs      <cmd>FzfPreviewGitStatus<CR>
" ANKI: Call FZF Preview Project Grep
nnoremap <space>gg      :FzfPreviewProjectGrep 

" ANKI: Call Fzf Preview File Plugins
nnoremap <space>fp      <cmd>FzfPreviewDirectoryFiles ~/plugins/<CR>

" ANKI: Call Fzf Preview on all plugins.
nnoremap <space>fa      <cmd>FzfPreviewDirectoryFiles ~/.local/share/nvim/site/pack/packer/start/<CR>

nnoremap <leader>en     <cmd>FzfPreviewDirectoryFiles ~/.config/nvim<CR>

nnoremap <leader>fc     <cmd>FzfPreviewDirectoryFiles ~/.config/<CR>

cmap <nowait> <space><c-r> <Plug>(TelescopeFuzzyCommandSearch)

nnoremap <space>rr <cmd>lua RELOAD('plenary'); RELOAD('telescope');<CR>

nnoremap <space>gw <cmd>lua RELOAD('telescope'); require('telescope.builtin').grep_string { shorten_path = true }<CR>

" Dotfiles
nnoremap <leader>en <cmd>lua RELOAD('plenary'); RELOAD('telescope'); require('telescope.builtin').git_files { shorten_path = true, cwd = "~/.config/nvim" }<CR>

" Telescope
nnoremap <space>fB <cmd>lua RELOAD('telescope'); require('telescope.builtin').builtin()<CR>

" General fuzzy
nnoremap <space>ft <cmd>lua RELOAD('plenary'); RELOAD('telescope'); require('telescope.builtin').git_files { shorten_path = true }<CR>
nnoremap <space>fg <cmd>lua RELOAD('plenary'); RELOAD('telescope'); require('telescope.builtin').live_grep { shorten_path = true }<CR>
nnoremap <space>fo <cmd>lua RELOAD('plenary'); RELOAD('telescope'); require('telescope.builtin').oldfiles()<CR>
nnoremap <space>fd <cmd>lua RELOAD('telescope'); require('telescope.builtin').fd()<CR>
nnoremap <space>fb <cmd>lua RELOAD('telescope'); require('telescope.builtin').buffers { shorten_path = true }<CR>

" Lsp
nnoremap <space>fr <cmd>lua RELOAD('plenary'); RELOAD('telescope'); require('telescope.builtin').lsp_references()<CR>
nnoremap <space>fw <cmd>lua RELOAD('plenary'); RELOAD('telescope'); require('telescope.builtin').lsp_workspace_symbols { ignore_filename = true }<CR>
