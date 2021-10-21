local nnoremap = vim.keymap.nnoremap

local ok, harpoon = pcall(require, "harpoon")
if not ok then
  return
end

harpoon.setup {}

nnoremap { "<M-h><M-m>", require("harpoon.mark").add_file }
nnoremap { "<M-h><M-l>", require("harpoon.ui").toggle_quick_menu }

for i = 1, 5 do
  nnoremap {
    string.format("<space>%s", i),
    function()
      require("harpoon.ui").nav_file(i)
    end,
  }
end
