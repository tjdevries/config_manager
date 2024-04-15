return {
  "elixir-tools/elixir-tools.nvim",
  enabled = false,
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local elixir = require "elixir"
    local elixirls = require "elixir.elixirls"

    elixir.setup {
      -- nextls = { enable = true },
      credo = { enable = false },
      elixirls = {
        enable = true,
        settings = elixirls.settings {
          dialyzerEnabled = false,
          enableTestLenses = false,
        },
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
          vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
          vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })

          require("tj.lsp").on_attach(client, bufnr)
        end,
      },
    }
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
