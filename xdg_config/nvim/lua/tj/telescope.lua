require('plenary.reload').reload_module('telescope')
require('plenary.reload').reload_module('plenary')
require('plenary.reload').reload_module('popup')


require('telescope').setup {
  defaults = {
    winblend = 0,
    layout_strategy = "horizontal",
    preview_cutoff = 120,

    sorting_strategy = "descending",
    prompt_position = "bottom",

    -- sorting_strategy = "ascending",
    -- prompt_position = "top",

    -- border = false,
    -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},

    -- for the top/right/bottom/left border.  Optionally
    -- followed by the character to use for the
    -- topleft/topright/botright/botleft corner.
    -- border = {},
    --   true,

    --   prompt = true,
    -- },

    borderchars = {
      { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},

      preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    },

    -- borderchars = { 'b', 'e', 'g', 'i', 'n', 'b', 'o', 't'}
  }

}

local should_reload = true
local reloader = function()
  if should_reload then
    RELOAD('plenary')
    RELOAD('telescope')
  end
end

local themes = require('telescope.themes')

local M = {}


--[[
lua require('plenary.reload').reload_module("my_user.tele")

nnoremap <leader>en <cmd>lua require('my_user.tele').edit_neovim()<CR>
--]]
function M.edit_neovim()
  reloader()

  require('telescope.builtin').git_files {
    shorten_path = false,
    cwd = "~/.config/nvim",
    prompt = "~ dotfiles ~",
    height = 10,

    layout_strategy = 'horizontal',
    layout_options = {
      preview_width = 0.75,
    },
  }
end

function M.builtin()
  reloader()

  require('telescope.builtin').builtin()
end

function M.git_files()
  reloader()

  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  require('telescope.builtin').git_files(opts)
end

function M.live_grep()
 reloader()

 require('telescope.builtin').live_grep {
   shorten_path = true
 }
end

function M.oldfiles()
  reloader()

  require('telescope.builtin').oldfiles()
end

function M.all_plugins()
  reloader()

  require('telescope.builtin').find_files {
    cwd = '~/plugins/',
  }
end

function M.installed_plugins()
  reloader()

  require('telescope.builtin').find_files {
    cwd = vim.fn.stdpath('data') .. '/site/pack/packer/start/'
  }
end

function M.project_search()
  reloader()

  require('telescope.builtin').find_files {
    previewer = false,
    layout_strategy = "vertical",
    cwd = require('nvim_lsp.util').root_pattern(".git")(vim.fn.expand("%:p")),
  }
end

function M.curbuf()
  reloader()

  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }
  require('telescope.builtin').current_buffer_fuzzy_find(opts)
end

return M
