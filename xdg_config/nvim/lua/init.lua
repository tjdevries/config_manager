
-- Load lsp config
local ok, msg = pcall(function() require('tj.lsp_config') end)
if not ok then
  print(msg)
end

RELOAD = require('plenary.reload').reload_module

R = function(name)
  RELOAD(name)
  return require(name)
end

P = function(v)
  print(vim.inspect(v))
  return v
end

-- TODO: Experiment with lua tree sitter and make it the coolest ever.
require('tj.completion')
require('tj.treesitter')
require('tj.statusline')
require('tj.snippets')

require('tj.telescope')
require('tj.telescope.mappings')

require('tj.plenary')
require('tj.grep')

require('tj.dap')


require('terminal').setup()

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
