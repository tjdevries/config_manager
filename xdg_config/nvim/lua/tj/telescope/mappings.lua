

local map_tele = function(key, f, options, buffer)
  local mode = "n"
  local rhs = string.format(
    "<cmd>lua R('tj.telescope')['%s'](%s)<CR>",
    f,
    options and vim.inspect(options, { newline = '' }) or ''
  )
  local options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, options)
  end
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
map_tele('<space>so', 'vim_options')
map_tele('<space>gp', 'grep_prompt')

-- Telescope Meta
map_tele('<space>fB', 'builtin')

return map_tele
