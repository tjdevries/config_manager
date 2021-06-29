local has_flutter_tools = pcall(require, "flutter-tools")
if not has_flutter_tools then
  return
end

local custom_lsp = require "tj.lsp"

-- local g = require('colorbuddy.group').groups

local Group = require("colorbuddy.group").Group
local c = require("colorbuddy.color").colors
local s = require("colorbuddy.style").styles

Group.new("FlutterClosingTag", c.gray3, nil, s.italic)
Group.new("FlutterWidgetGuides", c.gray2)

require("flutter-tools").setup {
  debugger = {
    enabled = true,
  },

  widget_guides = {
    enabled = true,
  },

  closing_tags = {
    enabled = true,
    highlight = "FlutterClosingTag",
    -- format = " </%s>",
    -- prefix = "~~ "
  },

  lsp = {
    on_attach = custom_lsp.on_attach,
    capabilities = custom_lsp.capabilities,
  },
}
