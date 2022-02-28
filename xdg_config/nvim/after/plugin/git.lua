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

-- hi NeogitNotificationInfo guifg=#80ff95
-- hi NeogitNotificationWarning guifg=#fff454
-- hi NeogitNotificationError guifg=#c44323
-- hi def NeogitDiffAddHighlight guibg=#404040 guifg=#859900
-- hi def NeogitDiffDeleteHighlight guibg=#404040 guifg=#dc322f
-- hi def NeogitDiffContextHighlight guibg=#333333 guifg=#b2b2b2
-- hi def NeogitHunkHeader guifg=#cccccc guibg=#404040
-- hi def NeogitHunkHeaderHighlight guifg=#cccccc guibg=#4d4d4d

-- git config --global merge.conflictStyle diff3
