local actions = require "telescope.actions"

require("telescope.builtin").buffers {
  layout_strategy = "vertical",
  layout_config = { mirror = true },
  sorting_strategy = "ascending",
  path_display = {
    "tail", -- TODO: change to "smart" when merged: https://github.com/caojoshua/telescope.nvim/pull/1
  },
  attach_mappings = function(_, map)
    map("i", "k", actions.move_selection_previous)
    map("i", "j", actions.move_selection_next)
    map("i", "x", actions.delete_buffer)
    return true
  end,
  scroll_strategy = "limit",
  on_complete = {
    function(picker)
      local buf = vim.api.nvim_win_get_buf(picker.original_win_id)
      local selection_index
      local idx = 1
      for entry in picker.manager:iter() do
        if entry.bufnr == buf then
          selection_index = idx
          break
        end
        idx = idx + 1
      end
      local row = picker:get_row(selection_index)
      picker:set_selection(row)
      picker._completion_callbacks = {}
    end,
  },
}
