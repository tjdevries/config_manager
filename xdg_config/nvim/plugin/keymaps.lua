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

nnoremap {
  "<space>dn",
  function()
    vim.diagnostic.goto_next()
  end,
}

nnoremap {
  "<space>dp",
  function()
    vim.diagnostic.goto_prev()
  end,
}

nnoremap { "<space>sl", vim.diagnostic.show_line_diagnostics }

-- nnoremap <M-j> :m .+1<CR>==
-- nnoremap <M-k> :m .-2<CR>==
