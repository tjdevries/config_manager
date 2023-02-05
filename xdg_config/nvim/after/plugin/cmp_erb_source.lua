---@diagnostic disable: need-check-nil

local debounce = require("telescope.debounce").debounce_leading
local Job = require "plenary.job"

local routes = {}

local w = vim.loop.new_fs_event()
vim.api.nvim_create_user_command("RubyStartPaths", function()
  if w then
    w:stop()
  else
    w = vim.loop.new_fs_event()
  end

  local on_change, watch_file
  on_change = debounce(function(err)
    if err then
      w:stop()
      return
    end

    -- Do work...
    Job:new({
      command = "bin/rails",
      args = { "route_formatter:json" },
      on_exit = function(self)
        routes = vim.json.decode(self:result()[1])
      end,
    }):start()
  end, 1000)

  watch_file = function(fname)
    local fullpath = vim.api.nvim_call_function("fnamemodify", { fname, ":p" })
    w:start(fullpath, { recursive = true }, on_change)
  end

  on_change(nil)
  watch_file "config/"
end, {})

vim.api.nvim_create_user_command("RubyStopPaths", function()
  w:stop()
  w = nil
end, {})

local source = {}

source.new = function()
  local self = setmetatable({ cache = {} }, { __index = source })

  return self
end

source.complete = function(self, _, callback)
  local bufnr = vim.api.nvim_get_current_buf()
  local items = {}
  for _, item in ipairs(routes) do
    table.insert(items, {
      label = string.format("%s_path", item),
      kind = vim.lsp.protocol.CompletionItemKind.EnumMember,
    })
    table.insert(items, {
      label = string.format("%s_url", item),
      kind = vim.lsp.protocol.CompletionItemKind.EnumMember,
    })
  end
  callback { items = items, isIncomplete = false }
end

source.get_trigger_characters = function()
  return { "#" }
end

source.is_available = function()
  return vim.bo.filetype == "eruby"
end

require("cmp").register_source("eruby", source.new())
