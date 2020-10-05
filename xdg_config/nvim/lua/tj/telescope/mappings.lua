

local map_tele = function(key, f, options)
  vim.api.nvim_set_keymap(
    "n",
    key,
    string.format(
      "<cmd>lua R('tj.telescope')['%s'](%s)<CR>",
      f,
      -- TODO: This is a bit of a hack... since it's possible inspect won't really work.
      options and vim.inspect(options, { newline = '' }) or ''
    ),
    {
      noremap = true,
    }
  )
end

vim.api.nvim_set_keymap('c', '<c-r><c-r>', '<Plug>(TelescopeFuzzyCommandSearch)', { noremap = false, nowait = true })

-- Dotfiles
map_tele('<leader>en', 'edit_neovim')
map_tele('<leader>ez', 'edit_zsh')

-- Search
map_tele('<space>gw', 'grep_string', { short_path = true, word_match = '-w' })

-- Files
map_tele('<space>ft', 'git_files')
map_tele('<space>fg', 'live_grep')
map_tele('<space>fo', 'oldfiles')
map_tele('<space>fd', 'fd')
map_tele('<space>pp', 'project_search')

-- Nvim
map_tele('<space>fb', 'buffers')
map_tele('<space>fp', 'my_plugins')
map_tele('<space>fa', 'installed_plugins')
map_tele('<space>ff', 'curbuf')
map_tele('<space>fh', 'help_tags')

-- Telescope Meta
map_tele('<space>fB', 'builtin')

-- LSP
map_tele('<space>fr', 'lsp_references')
map_tele('<space>fw', 'lsp_workspace_symbols', { ignore_filename = true })
