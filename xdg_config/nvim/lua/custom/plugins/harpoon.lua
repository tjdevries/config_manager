return {
  {
    "ThePrimeagen/harpoon",
    config = function()
      local nmap = require("tj.keymap").nmap

      local harpoon = require "harpoon"

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
    end,
  },
}
