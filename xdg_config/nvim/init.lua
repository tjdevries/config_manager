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

-- Load plugin confs
require('tj.far')

local opt = vim.opt

-- Ignore compiled files
opt.wildignore = '__pycache__'
opt.wildignore = opt.wildignore + { '*.o' , '*~', '*.pyc', '*pycache*' }

opt.wildmode = {'longest', 'list', 'full'}

-- Cool floating window popup menu for completion on command line
opt.pumblend = 17

opt.wildmode = opt.wildmode - 'list'
opt.wildmode = opt.wildmode + { 'longest', 'full' }

opt.wildoptions = 'pum'

opt.showmode       = false
opt.showcmd        = true
opt.cmdheight      = 1     -- Height of the command bar
opt.incsearch      = true  -- Makes search act like search in modern browsers
opt.showmatch      = true  -- show matching brackets when text indicator is over them
opt.relativenumber = true  -- Show line numbers
opt.number         = true  -- But show the actual number for the line we're on
opt.ignorecase     = true  -- Ignore case when searching...
opt.smartcase      = true  -- ... unless there is a capital letter in the query
opt.hidden         = true  -- I like having buffers stay around
opt.cursorline     = true  -- Highlight the current line
opt.equalalways    = false -- I don't like my windows changing all the time
opt.splitright     = true  -- Prefer windows splitting to the right
opt.splitbelow     = true  -- Prefer windows splitting to the bottom
opt.updatetime     = 1000  -- Make updates happen faster
opt.hlsearch       = true  -- I wouldn't use this without my DoNoHL function
opt.scrolloff      = 10    -- Make it so there are always ten lines below my cursor

-- Tabs
opt.autoindent     = true
opt.cindent        = true
opt.wrap           = true

opt.tabstop        = 4
opt.shiftwidth     = 4
opt.softtabstop    = 4
opt.expandtab      = true

opt.breakindent    = true
opt.showbreak      = string.rep(' ', 3) -- Make it so that long lines wrap smartly
opt.linebreak      = true

opt.foldmethod     = 'marker'
opt.foldlevel      = 0
opt.modelines      = 1

opt.belloff        = 'all' -- Just turn the dang bell off

opt.clipboard      = 'unnamedplus'

opt.inccommand     = 'split'
opt.swapfile       = false -- Living on the edge
opt.shada          = { "!", "'1000", "<50", "s10", "h" }

opt.mouse          = 'n'

-- Helpful related items:
--   1. :center, :left, :right
--   2. gw{motion} - Put cursor back after formatting motion.
--
-- TODO: w, {v, b, l}
opt.formatoptions = opt.formatoptions
                    - 'a'     -- Auto formatting is BAD.
                    - 't'     -- Don't auto format my code. I got linters for that.
                    + 'c'     -- In general, I like it when comments respect textwidth
                    + 'q'     -- Allow formatting comments w/ gq
                    - 'o'     -- O and o, don't continue comments
                    + 'r'     -- But do continue when pressing enter.
                    + 'n'     -- Indent past the formatlistpat, not underneath it.
                    + 'j'     -- Auto-remove comments if possible.
                    - '2'     -- I'm not in gradeschool anymore

-- set joinspaces
opt.joinspaces = false         -- Two spaces and grade school, we're done

-- set fillchars=eob:~
opt.fillchars = { eob = "~" }

--[[ To use a more declarative syntax, you could do something like this:

local function set_opts(opts_table)
  for k, v in pairs(opts_table) do
    vim.opt[k] = v
  end
end

set_opts {
  mouse = 'n',
  fillchars = { eob = "~" },
}

--]]

--[[ Global option names

For those wondering how to get the values at the top level,
    you could use Lua's `setfenv` function to set the environment
    equal to the vim.opt dict

cc @mccanch

setfenv(function()
    mouse = 'n'
end, vim.opt)()

--]]

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
