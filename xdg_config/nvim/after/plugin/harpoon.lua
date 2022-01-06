local nmap = require("tj.keymap").nmap

local ok, harpoon = pcall(require, "harpoon")
if not ok then
  return
end

harpoon.setup {}

nmap { "<M-h><M-m>", require("harpoon.mark").add_file }
nmap { "<M-h><M-l>", require("harpoon.ui").toggle_quick_menu }

for i = 1, 5 do
  nmap {
    string.format("<space>%s", i),
    function()
      require("harpoon.ui").nav_file(i)
    end,
  }
end
