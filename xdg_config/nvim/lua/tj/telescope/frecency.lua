
require('telescope').load_extension('frecency').setup {
  workspaces = {
    ["conf"] = "/home/tj/.config/nvim/",
    ["nvim"] = "/home/tj/build/neovim",
  }
}

vim.cmd [[highlight TelescopeBufferLoaded guifg=yellow]]
-- TelescopeBufferLoaded
-- TelescopePathSeparator
-- TelescopeFrecencyScores
-- TelescopeQueryFilter
