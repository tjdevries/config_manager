print(vim.api.nvim_cmd({
  cmd = "vsplit",
  args = { "%:h" },
  magic = {
    file = true,
  },
  mods = {
    silent = false,
    noautocmd = false,
  },
}, {
  output = true,
}))
