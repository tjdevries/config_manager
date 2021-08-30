--       __________________    __
--      /_  __/ ____/ ____/   / /    TJ DeVries
--       / / / __/ / __/ __  / /     https://github.com/tjdevries
--      / / / /___/ /___/ /_/ /      https://twitch.tv/teej_dv
--     /_/ /_____/_____/\____/

--[[ Notes to people reading my configuration!

Much of the configuration of individual plugins you can find in either:

./plugin/*.lua
  This is where many of the new plugin configurations live.

  These are sourced by using https://github.com/tjdevries/astronauta.nvim
  You can check out the readme there for more info.

./after/plugin/*.vim
  This is where configuration for plugins live.

  They get auto sourced on startup. In general, the name of the file configures
  the plugin with the corresponding name.

./lua/tj/*.lua
  This is where configuration/extensions for new style plugins live.

  They don't get sourced automatically, but do get sourced by doing something like:

    require('tj.dap')

  or similar. I generally recommend that people do this so that you don't accidentally
  override any of the plugin requires with namespace clashes. So don't just put your configuration
  in "./lua/dap.lua" because then it will override the plugin version of "dap.lua"

--]]

pcall(require, "impatient")

require "tj.profile"

if require "tj.first_load"() then
  return
end

-- Leader key -> ","
--
-- In general, it's a good idea to set this early in your config, because otherwise
-- if you have any mappings you set BEFORE doing this, they will be set to the OLD
-- leader.
vim.g.mapleader = ","

-- I set some global variables to use as configuration throughout my config.
-- These don't have any special meaning.
vim.g.snippets = "luasnip"

-- Setup globals that I expect to be always available.
--  See `./lua/tj/globals/*.lua` for more information.
require "tj.globals"

-- Turn off builtin plugins I do not use.
require "tj.disable_builtin"

-- Force loading of astronauta first.
vim.cmd [[runtime plugin/astronauta.vim]]

-- Neovim builtin LSP configuration
require "tj.lsp"

-- Telescope BTW
require "tj.telescope.setup"
require "tj.telescope.mappings"
