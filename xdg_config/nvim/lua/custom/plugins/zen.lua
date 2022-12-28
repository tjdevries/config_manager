return {
  {
    "folke/zen-mode.nvim",
    config = function()
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
      }

      require("twilight").setup {
        context = -1,
        treesitter = true,
      }
    end,
  },

  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        context = -1,
        treesitter = true,
      }
    end,
  },
}
