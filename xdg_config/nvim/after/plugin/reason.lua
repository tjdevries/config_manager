-- Add this to the path
vim.opt.runtimepath:append "/home/tjdevries/git/tree-sitter-reason"

-- Adds reason as a filetype
vim.filetype.add {
  extension = {
    re = "reason",
  },
}

-- Tells neovim to load reason
vim.treesitter.language.add("reason", { filetype = "reason" })
