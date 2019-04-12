--1 Required imports
-- luacheck: globals vim
vim.api.nvim_command('let g:colors_name = "gruvbuddy"')
vim.api.nvim_command('set termguicolors')
vim.api.nvim_command('set background=dark')
-- luacheck: globals Color
-- luacheck: globals c
-- luacheck: globals Group
-- luacheck: globals g
-- luacheck: globals s
Color = require('colorbuddy.init').Color
c = require('colorbuddy.init').colors

Group = require('colorbuddy.init').Group
g = require('colorbuddy.init').groups

s = require('colorbuddy.init').styles

-- local log = require('colorbuddy.log')
-- log.level = 'debug'

--1: Background and setup
local background_string = '#1d1f21'
Color.new('background', background_string)
Color.new('softwhite', '#ebdbb2')

Group.set_default('fg', c.none)
Group.set_default('bg', c.background)
Group.set_default('style', s.none)

--1 Color setup
Color.new('black',     '#1d1f21')
Color.new('gray0',     '#1d1f21')
Color.new('gray1',     '#282a2e')
Color.new('gray2',     '#373b41')
Color.new('gray3',     '#969896')
Color.new('gray4',     '#b4b7b4')
Color.new('gray5',     '#c5c8c6')
Color.new('gray6',     '#e0e0e0')
Color.new('gray7',     '#ffffff')

Color.new('white',     '#f2e5bc')
Color.new('red',       '#cc6666')
Color.new('pink',      '#fef601')
Color.new('green',     '#99cc99')
Color.new('yellow',    '#f8fe7a')
Color.new('blue',      '#81a2be')
Color.new('aqua',      '#8ec07c')
Color.new('cyan',      '#8abeb7')
Color.new('purple',    '#8e6fbd')
Color.new('violet',    '#b294bb')
Color.new('orange',    '#de935f')
Color.new('brown',     '#a3685a')

Color.new('seagreen',  '#698b69')
Color.new('turquoise', '#698b69')
-- Color.new('turquoise', c.blue:average(c.green))

--1 Vim Editor
Group.new('Normal', c.gray5, c.gray0)
Group.new('LineNr', c.gray3, c.gray1)
Group.new('EndOfBuffer', c.gray3)

Group.new('SignColumn', c.gray3, c.gray1)
--2 Cursor
Group.new('Cursor', g.normal.bg, g.normal.fg)
Group.new('CursorLine', nil, g.normal.bg:light(0.05))
--2 Popup Menu
Group.new('PMenu', c.gray4, c.gray2)
Group.new('PMenuSel', c.gray0, c.yellow:light())
Group.new('PMenuSbar', nil, c.gray0)
Group.new('PMenuThumb', nil, c.gray4)
--2 Quickfix Menu
Group.new('qfFileName', c.yellow, nil, s.bold)
--2 Statusline Colors
Group.new('StatusLine', c.gray2, c.blue, nil)
Group.new('StatusLineNC', c.gray3, c.gray1:light())
Group.new('User1', c.gray7, c.yellow, s.bold)
Group.new('User2', c.gray7, c.red, s.bold)
Group.new('User3', c.gray7, c.green, s.bold)
Group.new('CommandMode', c.gray7, c.green, s.bold)
Group.new('NormalMode', c.gray7, c.red, s.bold)
Group.new('InsertMode', c.gray7, c.yellow, s.bold)
Group.new('ReplaceMode', c.gray7, c.yellow, s.bold + s.underline)
Group.new('TerminalMode', c.gray7, c.turquoise, s.bold)
Group.new('HelpDoc', c.gray7, c.turquoise, s.bold + s.italic)

Group.new('Visual', nil, c.blue:dark(.3))
Group.new('VisualMode', g.Visual, g.Visual)
Group.new('VisualLineMode', g.Visual, g.Visual)

--2 Special Characters
Group.new('Special', c.purple:light(), nil, s.bold)
Group.new('SpecialChar', c.brown)
Group.new('NonText', c.gray2, nil, s.italic)
Group.new('WhiteSpace', c.purple)
--2 Searching
Group.new('Search', c.gray1, c.yellow)
--2 Tabline
Group.new('TabLine', c.gray7:light(), c.gray1)
Group.new('TabLineFill', c.softwhite, c.gray3)
Group.new('TabLineSel', c.white:light(), c.gray1, s.bold)
--2 Sign Column
--1 Standard syntax
Group.new('Boolean', c.orange)
Group.new('Comment', c.gray3, nil, nil)
Group.new('Character', c.red)
Group.new('Conditional', c.red)
Group.new('Define', c.cyan)
Group.new('Error', c.red:light(), nil, s.bold)

Group.new('Number', c.red)
Group.new('Float', g.Number, g.Number, g.Number)
Group.new('Constant', c.orange, nil, s.bold)

Group.new('Identifier', c.red, nil, s.bold)
Group.new('Include', c.cyan)
Group.new('Keyword', c.violet)
Group.new('Label', c.yellow)
Group.new('Operator', c.red:light():light())
Group.new('PreProc', c.yellow)
Group.new('Repeat', c.red)
Group.new('Repeat', c.red)
Group.new('Statement', c.red:dark(.1))
Group.new('StorageClass', c.yellow)
Group.new('String', c.green)
Group.new('Structure', c.violet)
Group.new('Tag', c.yellow)
Group.new('Todo', c.yellow)
Group.new('Type', c.yellow)
Group.new('Typedef', c.yellow)

Group.new('Type', c.yellow:dark(), nil, s.bold)
--2 Folded Items
Group.new('Folded', c.gray3:dark(), c.gray2:light())
--2 Function
Group.new('Function', c.yellow, c.background, s.bold)
Group.new('pythonBuiltinFunc', g.Function, g.Function, g.Function)
Group.new('vimFunction', g.Function, g.Function, g.Function)
-- TODO: Change to be able to just do g.Function:dark():dark()
Group.new('vimAutoloadFunction', g.Function.fg:dark():dark(), g.Function, g.Function)

--1 Language Syntax
--2 Python syntax
Group.new('pythonSelf', c.violet:light())
Group.new('pythonSelfArg', c.gray3, nil, s.italic)
Group.new('pythonOperator', c.red)

Group.new('pythonNone', c.red:light())
Group.new('pythonNone', c.red:light())
Group.new('pythonBytes', c.green, nil, s.italic)
Group.new('pythonRawBytes', g.pythonBytes, g.pythonBytes, g.pythonBytes)
Group.new('pythonBytesContent', g.pythonBytes, g.pythonBytes, g.pythonBytes)
Group.new('pythonBytesError', g.Error, g.Error, g.Error)
Group.new('pythonBytesEscapeError', g.Error, g.Error, g.Error)
Group.new('pythonBytesEscape', g.Special, g.Special, g.Special)
--2 Vim Syntax
Group.new('vimNotFunc', c.blue)
Group.new('vimCommand', c.blue)
Group.new('vimLet', c.purple:light())
Group.new('vimFuncVar', c.purple)
Group.new('vimCommentTitle', c.red, nil, s.bold)
Group.new('vimIsCommand', g.vimLet)

Group.new('vimMapModKey', c.cyan)
Group.new('vimNotation', c.cyan)
Group.new('vimMapLHS', c.yellow)
Group.new('vimNotation', c.cyan)
Group.new('vimBracket', c.cyan:negative():light())
Group.new('vimMap', c.seagreen)
Group.new('nvimMap', g.vimMap)
--2 Lua Syntax
Group.new('luaStatement', c.yellow:dark(), nil, s.bold)
Group.new('luaKeyword', c.orange:dark(), nil, s.bold)
Group.new('luaMyKeyword', c.purple:light(), nil, s.bold)
-- Group.new('luaFunction', c.blue:dark(), nil, nil)
Group.new('luaFunctionCall', c.blue:dark(), nil, nil)
Group.new('luaSpecialFunctions', c.blue:light(), nil, nil)
Group.new('luaMetatableEvents', c.purple, nil, nil)
Group.new('luaMetatableArithmetic', g.luaMetatableEvents, g.luaMetatableEvents, g.luaMetatableEvents)
Group.new('luaMetatableEquivalence', g.luaMetatableEvents, g.luaMetatableEvents, g.luaMetatableEvents)
--2 SQL Syntax
Group.new('SqlKeyword', c.red)
--2 HTML Syntax
Group.new('htmlH1', c.blue:dark(), nil, s.bold)
--1 Plugins
--2 Diff
Group.new('gitDiff', c.gray6:dark())

Group.new('DiffChange', nil, c.gray7 - c.red)
Group.new('DiffText', nil, c.red)
Group.new('DiffDelete', c.gray3, c.gray0)
Group.new('DiffAdded', c.green:dark())
Group.new('DiffRemoved', c.violet)
--2 MatchParen
Group.new('MatchParen', c.cyan)
--2 Startify
Group.new('StartifyBracket', c.red)
Group.new('StartifyFile', c.red:dark())
Group.new('StartifyNumber', c.blue)
Group.new('StartifyPath', c.green:dark())
Group.new('StartifySlash', c.cyan, nil, s.bold)
Group.new('StartifySection', c.yellow:light())
Group.new('StartifySpecial', c.orange)
Group.new('StartifyHeader', c.orange)
Group.new('StartifyFooter', c.gray2)
--2 Vimwiki
Group.new('VimwikiBold', c.red, nil, s.bold)
--1 TODO:
-- CPHL SneakPluginTarget blue,bright black,dark,dark,dark,dark bold
-- CPHL htmlH1 blue,dark - bold
--
--
--
--  Semshi
--
-- Original hi semshiSelf            ctermfg=249 guifg=#b2b2b2
Group.new('semshiSelf', g.pythonSelf, g.pythonSelf, g.pythonSelf)

-- Original hi semshiLocal           ctermfg=209 guifg=#ff875f
Group.new('semshiLocal', nil, nil, nil)
-- Original hi semshiImported        ctermfg=214 guifg=#ffaf00 cterm=bold gui=bold
Group.new('semshiImported', c.blue, nil)
-- Original hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f
Group.new('semshiSelected', nil, c.background:light())

-- This one doesn't seem to be very reliable.
-- Original hi semshiFree            ctermfg=218 guifg=#ffafd7
Group.new('semshiFree', nil, nil, nil)

-- TODO:
-- Original hi semshiGlobal          ctermfg=214 guifg=#ffaf00
-- Original hi semshiParameter       ctermfg=75  guifg=#5fafff
-- Original hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
-- Original hi semshiBuiltin         ctermfg=207 guifg=#ff5fff
-- Original hi semshiAttribute       ctermfg=49  guifg=#00ffaf
-- Original hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
-- Original hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
-- Original hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
-- sign define semshiError text=E> texthl=semshiErrorSign
