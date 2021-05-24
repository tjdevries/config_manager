local colors = require("colorbuddy.color").colors

local ns_tj = vim.api.nvim_create_namespace "tj_colors"
local ns_tj_2 = vim.api.nvim_create_namespace "tj_colors_2"

vim.api.nvim_set_decoration_provider(ns_tj, {
  on_start = function(_, tick)
  end,

  on_buf = function(_, bufnr, tick)
  end,

  on_win = function(_, winid, bufnr, topline, botline)
  end,

  on_line = function(_, winid, bufnr, row)
    if row == 10 then
      vim.api.nvim_set_hl_ns(ns_tj_2)
    else
      vim.api.nvim_set_hl_ns(ns_tj)
    end
  end,

  on_end = function(_, tick)
  end,
})

vim.api.nvim_set_hl(ns_tj, "LuaFunctionCall", {
  foreground = colors.green:to_rgb(),
  background = nil,
  reverse = false,
  underline = false,
})

vim.api.nvim_set_hl_ns(ns_tj)
