local nnoremap = vim.keymap.nnoremap

-- vim.fn["gina#custom#command#option"]('status', '--opener', 'vsplit')
-- nnoremap { '<leader>gs', '<cmd>Gina status<CR>' }

local ok, neogit = pcall(require, "neogit")
if not ok then
  return
end

neogit.setup {
  integrations = {
    diffview = true,
  },
}

nnoremap { "<leader>gs", neogit.open }
nnoremap {
  "<leader>gc",
  function()
    neogit.open { "commit" }
  end,
}
