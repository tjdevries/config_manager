-- in plugin
require("lspconfig").jdtls.replace {
  init = {
    pre = function()
    end,

    post = function()
    end,
  },

  attach = {
    pre = function()
    end,

    post = function()
    end,
  },
}

-- In user config:
require("custom-jdtls").setup {
  random_key_doesnt_matter = {},
  another_thing = "who cares",
}

require("lspconfig").jdtls.setup {
  on_attach = my_attach,
}
