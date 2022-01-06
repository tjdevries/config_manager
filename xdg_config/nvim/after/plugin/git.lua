-- vim.fn["gina#custom#command#option"]('status', '--opener', 'vsplit')
-- nnoremap { '<leader>gs', '<cmd>Gina status<CR>' }

local ok, neogit = pcall(require, "neogit")
if not ok then
  return
end

local nmap = require("tj.keymap").nmap

neogit.setup {
  integrations = {
    diffview = true,
  },
}

nmap { "<space>vv", ":DiffviewOpen " }

nmap { "<leader>gs", neogit.open }
nmap {
  "<leader>gc",
  function()
    neogit.open { "commit" }
  end,
}
