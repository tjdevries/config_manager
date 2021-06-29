local nnoremap = vim.keymap.nnoremap

-- vim.fn["gina#custom#command#option"]('status', '--opener', 'vsplit')
-- nnoremap { '<leader>gs', '<cmd>Gina status<CR>' }

local neogit = require "neogit"

neogit.setup {}

nnoremap { "<leader>gs", neogit.open }
nnoremap { "<leader>gc", function()
  neogit.open { "commit" }
end }
