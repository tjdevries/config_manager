
-- Load lsp config
local ok, _ = pcall(function() require('lsp_config') end)

-- TODO: Experiment with lua tree sitter and make it the coolest ever.
require('tj.completion')
require('tj.treesitter')
require('tj.statusline')
require('tj.snippets')
require('tj.telescope')

RELOAD = require('plenary.reload').reload_module

-- Run the first time to install it
if false then
  -- Load required packages
  local neorocks = require("plenary.neorocks")

  neorocks.install('penlight', 'pl')
  neorocks.install('luasocket', 'socket')

  neorocks.ensure_installed('penlight', 'pl')
  neorocks.ensure_installed('lua-cjson', 'cjson')
  neorocks.ensure_installed('luasocket', 'socket')
  neorocks.ensure_installed('moses', 'moses')
end
