-- TODO:
--
-- use "simrat39/rust-tools.nvim"
-- use "ray-x/go.nvim"
-- use {
--   "ericpubu/lsp_codelens_extensions.nvim",
--   config = function()
--     require("codelens_extensions").setup()
--   end,
-- }
-- use {
--   "folke/lsp-trouble.nvim",
--   cmd = "Trouble",
--   config = function()
--     -- Can use P to toggle auto movement
--     require("trouble").setup {
--       auto_preview = false,
--       auto_fold = true,
--     }
--   end,
-- }

-- use {
--   "folke/noice.nvim",
--   event = "VimEnter",
--   config = function()
--     require("noice").setup()
--   end,
--   requires = {
--     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
--     "MunifTanjim/nui.nvim",
--     "rcarriga/nvim-notify",
--   },
-- }

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "tj.lsp"
    end,
  },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup {
        auto_update = true,
        debounce_hours = 24,
        ensure_installed = {
          "black",
          "isort",
        },
      }
    end,
  },

  "simrat39/inlay-hints.nvim",
  { "j-hui/fidget.nvim", branch = "legacy" },
  "folke/neodev.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "jose-elias-alvarez/nvim-lsp-ts-utils",
  "scalameta/nvim-metals",
  "b0o/schemastore.nvim",
  -- { "pjlast/llmsp", build = "go install" },
}
