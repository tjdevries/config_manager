vim.opt.termguicolors = true

require('colorbuddy').colorscheme('gruvbuddy')
require('colorizer').setup() 

local c = require('colorbuddy.color').colors
local Group = require('colorbuddy.group').Group

Group.new('GoTestSuccess', c.green, nil, s.bold)
Group.new('GoTestFail', c.red, nil, s.bold)
