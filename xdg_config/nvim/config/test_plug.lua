return {
  enabled = true,

  settings = {
    debug = true,
    enabled_servers = {
      "rust-analyzer",
      "sumneko",
    },
    set_omnifunc = true,
  },

  -- maps = { default = "lexima" },
  -- maps = { buffer = { $NAME = { n = { ... } } } }
  maps = {
    -- global mappings
    i = {
      -- inoremap <silent><expr> <C-Space> compe#complete()
      -- ["<c-space>"] = "Complete",
    },

    n = {
      ["<space>kj"] = "EchoHello",
      ["<space>kk"] = "UsesCommand",
    },

    group = {
      lsp = {
        n = {
          gD = "LspDecaration", -- <- this line is an error. Not valid
          gd = "LspDefinition",
          K = "LspHover",
          -- ...
          ["<space>f"] = "LspFormatting",
        },
      },
    },
  },
}
