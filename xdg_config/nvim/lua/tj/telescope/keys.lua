local sorters = require "telescope.sorters"

local map_tele = require "tj.telescope.mappings"

-- Dotfiles
map_tele("<leader>en", "edit_neovim")
map_tele("<leader>ez", "edit_zsh")
map_tele("<space><space>d", "diagnostics")

-- Search
-- TODO: I would like to completely remove _mock from my search results here when I'm in SG/SG
map_tele("<space>gw", "grep_string", {
  word_match = "-w",
  short_path = true,
  only_sort_text = true,
  layout_strategy = "vertical",
})

map_tele("<space>f/", "grep_open_files", {
  layout_strategy = "vertical",
})

-- Files
map_tele("<space>ft", "git_files")
map_tele("<space>fg", "multi_rg")
map_tele("<space>fo", "oldfiles")
map_tele("<space>fd", "find_files")
map_tele("<space>fs", "fs")
map_tele("<space>pp", "project_search")
map_tele("<space>fv", "find_nvim_source")
map_tele("<space>fe", "file_browser")
map_tele("<space>fz", "search_only_certain_files")

-- Sourcegraph
map_tele("<space>sf", "sourcegraph_find")
map_tele("<space>saf", "sourcegraph_about_find")
map_tele("<space>sag", "sourcegraph_about_grep")
-- map_tele('<space>fz', 'sourcegraph_tips')

-- Git
map_tele("<space>gs", "git_status")
map_tele("<space>gc", "git_commits")

-- Nvim
map_tele("<space>fb", "buffers")
map_tele("<space>fp", "my_plugins")
map_tele("<space>fa", "installed_plugins")
map_tele("<space>fi", "search_all_files")
map_tele("<space>ff", "curbuf")
map_tele("<space>fh", "help_tags")
map_tele("<space>bo", "vim_options")
map_tele("<space>gp", "grep_prompt")
map_tele("<space>wt", "treesitter")

-- Telescope Meta
map_tele("<space>fB", "builtin")
