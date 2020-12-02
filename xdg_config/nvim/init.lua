--       __________________    __
--      /_  __/ ____/ ____/   / /    TJ DeVries
--       / / / __/ / __/ __  / /     https://github.com/tjdevries
--      / / / /___/ /___/ /_/ /      https://twitch.tv/teej_dv
--     /_/ /_____/_____/\____/

--[[ Notes to people reading my configuration!

Much of the configuration of individual plugins you can find in either:

./after/plugin/*.vim
  This is where configuration for plugins live.

  They get auto sourced on startup. In general, the name of the file configures
  the plugin with the corresponding name.

./lua/tj/*.lua
  This is where configuration for new style plugins live.

  They don't get sourced automatically, but do get sourced by doing something like:

    require('tj.dap')

  or similar. I generally recommend that people do this so that you don't accidentally
  override any of the plugin requires with namespace clashes. So don't just put your configuration
  in "./lua/dap.lua" because then it will override the plugin version of "dap.lua"

--]]

-- TODO: Consider what to do with ginit.vim

vim.cmd [[packadd vimball]]

-- Leader key -> ","
--
-- In general, it's a good idea to set this early in your config, because otherwise
-- if you have any mappings you set BEFORE doing this, they will be set to the OLD
-- leader.
vim.g.mapleader = ','

-- Load packer.nvim files
require('tj.plugins')

package.loaded['tj.globals'] = nil
require('tj.globals')

local set = vim.set

-- Ignore compiled files
set.wildignore = '__pycache__'
set.wildignore = set.wildignore + { '*.o' , '*~', '*.pyc', '*pycache*' }

set.wildmode = {'longest', 'list', 'full'}

-- Cool floating window popup menu for completion on command line
set.pumblend = 17

set.wildmode = set.wildmode - 'list'
set.wildmode = set.wildmode + { 'longest', 'full' }

set.wildoptions = 'pum'

set.showmode       = false
set.showcmd        = true
set.cmdheight      = 1     -- Height of the command bar
set.incsearch      = true  -- Makes search act like search in modern browsers
set.showmatch      = true  -- show matching brackets when text indicator is over them
set.relativenumber = true  -- Show line numbers
set.number         = true  -- But show the actual number for the line we're on
set.ignorecase     = true  -- Ignore case when searching...
set.smartcase      = true  -- ... unless there is a capital letter in the query
set.hidden         = true  -- I like having buffers stay around
set.cursorline     = true  -- Highlight the current line
set.equalalways    = false                      -- I don't like my windows changing all the time
set.splitright     = true                         -- Prefer windows splitting to the right
set.splitbelow     = true                         -- Prefer windows splitting to the bottom
set.updatetime     = 1000                    -- Make updates happen faster
set.hlsearch       = true -- I wouldn't use this without my DoNoHL function
set.scrolloff      = 10                      -- Make it so there are always ten lines below my cursor

-- Tabs
set.autoindent     = true
set.cindent        = true
set.wrap           = true

set.tabstop        = 4
set.shiftwidth     = 4
set.softtabstop    = 4
set.expandtab      = true

set.breakindent    = true
set.showbreak      = string.rep(' ', 3) -- Make it so that long lines wrap smartly
set.linebreak      = true

set.foldmethod     = 'marker'
set.foldlevel      = 0
set.modelines      = 1

set.belloff        = 'all' -- Just turn the dang bell off

set.clipboard      = 'unnamedplus'

set.inccommand     = 'split'
set.swapfile       = false -- Living on the edge
set.shada          = { "!", "'1000", "<50", "s10", "h" }

set.mouse          = 'n'

-- Helpful related items:
--   1. :center, :left, :right
--   2. gw{motion} - Put cursor back after formatting motion.
--
-- TODO: w, {v, b, l}

--[[
set.formatoptions = set.formatoptions
                    - 'a'     -- Auto formatting is BAD.
                    - 't'     -- Don't auto format my code. I got linters for that.
                    + 'c'     -- In general, I like it when comments respect textwidth
                    + 'q'     -- Allow formatting comments w/ gq
                    - 'o'     -- O and o, don't continue comments
                    + 'r'     -- But do continue when pressing enter.
                    + 'n'     -- Indent past the formatlistpat, not underneath it.
                    + 'j'     -- Auto-remove comments if possible.
                    - '2'     -- I'm not in gradeschool anymore
--]]

set.joinspaces = false         -- Two spaces and grade school, we're done

-- set fillchars=eob:⠀
set.fillchars = { eob = "~" }

--[[
guicursor messing around
set guicursor=n:blinkwait175-blinkoff150-blinkon175-hor10
set guicursor=a:blinkon0

disable netrw.vim
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
--]]
