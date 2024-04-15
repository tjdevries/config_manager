-- Add this to the path
vim.opt.runtimepath:append "/home/tjdevries/git/tree-sitter-monkey"

-- Adds monkey as a filetype
vim.filetype.add {
  extension = {
    mk = "monkey",
  },
}

-- Tells neovim to load monkey
vim.treesitter.language.add("monkey", { filetype = "monkey" })
