--       __________________    __
--      /_  __/ ____/ ____/   / /    TJ DeVries
--       / / / __/ / __/ __  / /     https://github.com/tjdevries
--      / / / /___/ /___/ /_/ /      https://twitch.tv/teej_dv
--     /_/ /_____/_____/\____/

PROFILE_LOAD = false
if PROFILE_LOAD then
  require("jit.p").start("10,i1,s,m0,G", "/tmp/output_flame.log")
  vim.cmd [[au VimLeave * lua require'jit.p'.stop()]]
end

--[[ Notes to people reading my configuration!

Much of the configuration of individual plugins you can find in either:

./lua/plugin/*.lua
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

if require "tj.first_load"() then
  return
end

-- Leader key -> ","
--
-- In general, it's a good idea to set this early in your config, because otherwise
-- if you have any mappings you set BEFORE doing this, they will be set to the OLD
-- leader.
vim.g.mapleader = ","

vim.g.snippets = "luasnip"

-- Setup globals that I expect to be always available.
--  See `./lua/tj/globals/*.lua` for more information.
require "tj.globals"

-- Force loading of astronauta first.
vim.cmd [[runtime plugin/astronauta.vim]]

-- Load neovim options
require "tj.options"

-- Neovim builtin LSP configuration
require "tj.lsp"

-- Telescope BTW
require "tj.telescope"
require "tj.telescope.mappings"
