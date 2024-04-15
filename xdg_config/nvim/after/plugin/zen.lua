if not pcall(require, "zen-mode") then
  return
end

require("zen-mode").setup {
  window = {
    backdrop = 1,
    height = 0.9,
    -- width = 140,
    options = {
      number = false,
      relativenumber = false,
      signcolumn = "no",
      list = false,
      cursorline = false,
    },
  },
  plugins = {
    twilight = { enabled = false },
  },
}

require("twilight").setup {
  context = -1,
  treesitter = true,
}
