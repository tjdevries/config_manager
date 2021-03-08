vim.opt.termguicolors = true

require('colorbuddy').colorscheme('gruvbuddy')
require('colorizer').setup() 

local c = require('colorbuddy.color').colors
local Group = require('colorbuddy.group').Group

Group.new('GoTestSuccess', c.green, nil, s.bold)
Group.new('GoTestFail', c.red, nil, s.bold)

-- Group.new('Keyword', c.purple, nil, nil)

Group.new('TSPunctBracket', c.orange:light():light())

Group.new('StatuslineError1', c.red:light():light(), g.Statusline)
Group.new('StatuslineError2', c.red:light(), g.Statusline)
Group.new('StatuslineError3', c.red, g.Statusline)
Group.new('StatuslineError3', c.red:dark(), g.Statusline)
Group.new('StatuslineError3', c.red:dark():dark(), g.Statusline)
