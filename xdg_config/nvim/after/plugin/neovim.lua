local nnoremap = vim.keymap.nnoremap

nnoremap {
  "<space>dg",
  function()
    local file = vim.fn.expand "%"
    local line = vim.fn.line "."
    vim.fn.setreg("+", string.format("break %s:%s", file, line))
  end,
}

nnoremap { "<space>dp", function()
  vim.fn.setreg("+", string.format("attach %s", vim.fn.getpid()))
end }
