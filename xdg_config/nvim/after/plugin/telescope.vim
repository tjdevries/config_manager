cmap <nowait> <c-r><c-r> <Plug>(TelescopeFuzzyCommandSearch)

nnoremap <space>gw <cmd>lua RELOAD('telescope'); require('telescope.builtin').grep_string { shorten_path = true, word_match = '-w' }<CR>

" Dotfiles
nnoremap <leader>en <cmd>lua RELOAD('tj.telescope'); R('tj.telescope').edit_neovim()<CR>

" Telescope
nnoremap <space>fB <cmd>lua R('tj.telescope').builtin()<CR>

" General fuzzy
nnoremap <space>ft <cmd>lua R('tj.telescope').git_files()<CR>
nnoremap <space>fg <cmd>lua R('tj.telescope').live_grep()<CR>
nnoremap <space>fo <cmd>lua R('tj.telescope').oldfiles()<CR>
nnoremap <space>fd <cmd>lua RELOAD('telescope'); require('telescope.builtin').fd()<CR>
nnoremap <space>fb <cmd>lua RELOAD('telescope'); require('telescope.builtin').buffers { shorten_path = false }<CR>
nnoremap <space>fp <cmd>lua R('tj.telescope').all_plugins()<CR>
nnoremap <space>fa <cmd>lua R('tj.telescope').installed_plugins()<CR>
nnoremap <space>ff <cmd>lua R('tj.telescope').curbuf()<CR>
nnoremap <space>pp <cmd>lua R('tj.telescope').project_search()<CR>
nnoremap <space>fh <cmd>lua R('telescope.builtin').help_tags { show_version = true }<CR>

" Lsp
nnoremap <space>fr <cmd>lua RELOAD('plenary'); RELOAD('telescope'); require('telescope.builtin').lsp_references()<CR>
nnoremap <space>fw <cmd>lua RELOAD('plenary'); RELOAD('telescope'); require('telescope.builtin').lsp_workspace_symbols { ignore_filename = true }<CR>
