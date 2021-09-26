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

nnoremap { "<space>dn", vim.diagnostic.goto_next }
nnoremap { "<space>dp", vim.diagnostic.goto_prev }
nnoremap { "<space>sl", vim.diagnostic.show_line_diagnostics }

-- nnoremap <M-j> :m .+1<CR>==
-- nnoremap <M-k> :m .-2<CR>==
