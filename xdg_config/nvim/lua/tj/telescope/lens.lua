local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local utils = require "telescope.utils"

local conf = require("telescope.config").values

local M = {}

M._create_workspace_handler = function(opts)
  local bufnr = vim.api.nvim_get_current_buf()

  return function(_, _, result)
    print "In the callback..."
    local locations = {}

    if not result then
      print "No results from workspace/symbol"
    else
      locations = vim.lsp.util.symbols_to_items(result, bufnr)
    end

    if not locations then
      locations = {}
    end

    pickers.new(opts, {
      prompt_title = "LSP Workspace Symbols",
      finder = finders.new_table {
        results = locations,
        entry_maker = make_entry.gen_from_lsp_symbols(opts),
      },
      previewer = conf.qflist_previewer(opts),
      sorter = conf.generic_sorter(opts),

      on_input_filter_cb = function(prompt)
        local params = { query = "#" .. prompt }
        local new_result = vim.lsp.buf_request_sync(bufnr, "workspace/symbol", params)
        local new_locations = {}
        for _, server_results in pairs(new_result or {}) do
          if server_results.result then
            vim.list_extend(new_locations, vim.lsp.util.symbols_to_items(server_results.result, 0) or {})
          end
        end

        return {
          prompt = prompt,
          updated_finder = finders.new_table {
            results = new_locations,
            entry_maker = make_entry.gen_from_lsp_symbols(opts),
          },
        }
      end,
    }):find()
  end
end

M.live_workspace_symbols = function(opts)
  opts = opts or {}

  opts.shorten_path = utils.get_default(opts.shorten_path, true)
  opts.ignore_filename = utils.get_default(opts.ignore_filename, false)
  opts.hide_filename = utils.get_default(opts.hide_filename, false)

  local params = { query = opts.query or "#" }

  vim.lsp.buf_request(0, "workspace/symbol", params, M._create_workspace_handler(opts))
end

return M
