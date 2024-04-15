local set = vim.opt_local

-- Don't do comment stuffs when I use o/O
set.formatoptions:remove "o"

-- after/ftplugin/<filetype>.lua

-- Setup debug mapping, only for current file
vim.keymap.set("n", "<F5>", function()
  if require("dap").session() then
    require("dap").continue()
  else
    require("tj.dap").select_rust_runnable()
  end
end, { buffer = 0 })
