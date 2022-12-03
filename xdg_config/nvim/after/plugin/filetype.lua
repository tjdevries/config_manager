vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd.set "filetype=term"
  end,
})

vim.filetype.add {
  extension = {
    fnl = "fennel",
    wiki = "markdown",
  },
  filename = {
    ["go.sum"] = "gosum",
    ["go.mod"] = "gomod",
  },
}
