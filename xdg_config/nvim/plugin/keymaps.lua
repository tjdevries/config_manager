local nnoremap = vim.keymap.nnoremap

nnoremap {
  "<M-j>",
  function()
    if vim.opt.diff:get() then
      vim.cmd [[normal! ]c]]
    else
      vim.cmd [[m .+1<CR>==]]
    end
  end,
}

nnoremap {
  "<M-k>",
  function()
    if vim.opt.diff:get() then
      vim.cmd [[normal! [c]]
    else
      vim.cmd [[m .-2<CR>==]]
    end
  end,
}
-- nnoremap <M-j> :m .+1<CR>==
-- nnoremap <M-k> :m .-2<CR>==
