

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
" ANKI: Call FZF Preview Buffers
nnoremap <space>if      <cmd>FzfPreviewBuffers<CR>
" ANKI: Call FZF Preview Git Status
nnoremap <space>gs      <cmd>FzfPreviewGitStatus<CR>
" ANKI: Call FZF Preview Project Grep
nnoremap <space>gg      :FzfPreviewProjectGrep 

" ANKI: Call Fzf Preview on all plugins.

nnoremap <leader>fc     <cmd>FzfPreviewDirectoryFiles ~/.config/<CR>

cmap <nowait> <c-r><c-r> <Plug>(TelescopeFuzzyCommandSearch)

nnoremap <space>rr <cmd>lua RELOAD('plenary'); RELOAD('telescope');<CR>

nnoremap <space>gw <cmd>lua RELOAD('telescope'); require('telescope.builtin').grep_string { shorten_path = true }<CR>

" Dotfiles
nnoremap <leader>en <cmd>lua R('tj.telescope').edit_neovim()<CR>

" Telescope
nnoremap <space>fB <cmd>lua R('tj.telescope').builtin()<CR>

" General fuzzy
nnoremap <space>ft <cmd>lua R('tj.telescope').git_files()<CR>
nnoremap <space>fg <cmd>lua R('tj.telescope').live_grep()<CR>
nnoremap <space>fo <cmd>lua R('tj.telescope').oldfiles()<CR>
nnoremap <space>fd <cmd>lua RELOAD('telescope'); require('telescope.builtin').fd()<CR>
nnoremap <space>fb <cmd>lua RELOAD('telescope'); require('telescope.builtin').buffers { shorten_path = true }<CR>
nnoremap <space>fp <cmd>lua R('tj.telescope').all_plugins()<CR>
nnoremap <space>fa <cmd>lua R('tj.telescope').installed_plugins()<CR>
nnoremap <space>ff <cmd>lua R('telescope.builtin').current_buffer_fuzzy_find()<CR>

" Lsp
nnoremap <space>fr <cmd>lua RELOAD('plenary'); RELOAD('telescope'); require('telescope.builtin').lsp_references()<CR>
nnoremap <space>fw <cmd>lua RELOAD('plenary'); RELOAD('telescope'); require('telescope.builtin').lsp_workspace_symbols { ignore_filename = true }<CR>
