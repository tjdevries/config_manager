return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local list = require("nvim-treesitter.parsers").get_parser_configs()
      list.lua = {
        install_info = {
          url = "https://github.com/tjdevries/tree-sitter-lua",
          revision = "0e860f697901c9b610104eb61d3812755d5211fc",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "master",
        },
      }
      list.rsx = {
        install_info = {
          url = "https://github.com/tjdevries/tree-sitter-rsx",
          files = { "src/parser.c", "src/scanner.cc" },
          branch = "master",
        },
      }
    end,
  },
  { dir = "~/plugins/tree-sitter-lua" },
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- "vigoux/architext.nvim"
  -- {
  --     "mfussenegger/nvim-ts-hint-textobject",
  --     config = function()
  --       vim.cmd [[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
  --       vim.cmd [[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]
  --     end,
  --   }
}
