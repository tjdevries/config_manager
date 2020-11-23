
-- Auto close with escape
-- Make selections with ^k and ^j
local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-k>"] = actions.move_selection_next,
        ["<c-j>"] = actions.move_selection_prev,
      }
    }
  }
}

require('telescope').setup {
  defaults = {
    sorting_strategy = "ascending",
    prompt_position = "top",
  }
}
