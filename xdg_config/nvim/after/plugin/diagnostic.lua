local nmap = require("tj.keymap").nmap

vim.diagnostic.config {
  underline = true,
  virtual_text = {
    severity = nil,
    source = "if_many",
    format = nil,
  },
  signs = true,

  -- options for floating windows:
  float = {
    show_header = true,
  },

  -- general purpose
  severity_sort = true,
  update_in_insert = false,
}

local goto_opts = {
  wrap = true,
  float = true,
}

nmap {
  "<space>dn",
  function()
    vim.diagnostic.goto_next(goto_opts)
  end,
}

nmap {
  "<space>dp",
  function()
    vim.diagnostic.goto_prev(goto_opts)
  end,
}

nmap {
  "<space>sl",
  function()
    vim.diagnostic.open_float(0, {
      scope = "line",
    })
  end,
}
