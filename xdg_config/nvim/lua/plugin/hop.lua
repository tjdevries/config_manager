if true then
  return
end

local c = require("colorbuddy.color").colors
local Group = require("colorbuddy.group").Group
local s = require("colorbuddy.style").styles

vim.api.nvim_set_keymap("n", "s", ":HopWord<CR>", { silent = true, noremap = false })
vim.api.nvim_set_keymap("n", "<space><space>", ":HopWord<CR>", { silent = true, noremap = false })
vim.api.nvim_set_keymap("n", "<M-/>", ":HopWord<CR>", { silent = true, noremap = false })

Group.new("HopNextKey", c.pink, nil, s.bold)
Group.new("HopNextKey1", c.cyan:saturate(), nil, s.bold)
Group.new("HopNextKey2", c.cyan:dark(), nil)

require("hop").setup {
  keys = "asdfqwer;lkjpoiuxcv,mnhytgb",
}
