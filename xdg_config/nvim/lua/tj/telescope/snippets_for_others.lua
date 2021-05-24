--[[
This is just some examples of what you can do with telescope that people wanted to see
on stream.

I don't use these necessarily, but they are for showing examples of things.
--]]

-- Auto close with escape
-- Make selections with ^k and ^j
local actions = require "telescope.actions"
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-k>"] = actions.move_selection_next,
        ["<c-j>"] = actions.move_selection_prev,
      },
    },
  },
}

require("telescope").setup {
  defaults = {
    sorting_strategy = "ascending",
    prompt_position = "top",
  },
}
