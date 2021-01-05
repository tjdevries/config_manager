
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


require('terminal').setup()

for _, mod in ipairs(vim.api.nvim_get_runtime_file('lua/auto/**/*.lua', true)) do
  ok, msg = pcall(loadfile(mod))

  if not ok then
    print("Failed to load: ", mod)
    print("\t", msg)
  end
end
