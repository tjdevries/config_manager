local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"

vim.ui = {}
vim.ui.pick_one = function(items, prompt, label_fn, cb)
  local value

  local opts = {}
  pickers.new(opts, {
    prompt_title = prompt,
    finder = finders.new_table {
      results = items,
      entry_maker = function(entry)
        return {
          value = entry,
          display = label_fn(entry),
          ordinal = label_fn(entry),
        }
      end,
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        value = selection
      end)

      return true
    end,
  }):find()

  vim.wait(5000, function()
    return value ~= nil
  end, nil, false)
end

print("Picked:", vim.ui.pick_one({ "hello", "world", "this", "is", "true" }, "Pick one > ", function(entry)
  return entry
end))
