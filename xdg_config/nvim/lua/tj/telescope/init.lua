local should_reload = true
local reloader = function()
  if should_reload then
    RELOAD('plenary')
    RELOAD('popup')
    RELOAD('telescope')
  end
end

reloader()

local sorters = require('telescope.sorters')
local themes = require('telescope.themes')

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

    file_sorter = sorters.get_fzy_sorter,

    color_devicons = true,
  }
}

local M = {}

--[[
lua require('plenary.reload').reload_module("my_user.tele")

nnoremap <leader>en <cmd>lua require('my_user.tele').edit_neovim()<CR>
--]]
function M.edit_neovim()
  require('telescope.builtin').find_files {
    prompt_title = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/.config/nvim",
    height = 10,

    layout_strategy = 'horizontal',
    layout_config = {
      preview_width = 0.65,
    },
  }
end

function M.edit_zsh()
  require('telescope.builtin').find_files {
    shorten_path = false,
    cwd = "~/.config/zsh/",
    prompt = "~ dotfiles ~",
    height = 10,

    layout_strategy = 'horizontal',
    layout_config = {
      preview_width = 0.55,
    },
  }
end


function M.fd()
  require('telescope.builtin').fd()
end

function M.builtin()
  require('telescope.builtin').builtin()
end

function M.git_files()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  require('telescope.builtin').git_files(opts)
end

function M.live_grep()
 require('telescope.builtin').live_grep {
   shorten_path = true
 }
end

function M.oldfiles()
  require('telescope.builtin').oldfiles()
end

function M.my_plugins()
  require('telescope.builtin').find_files {
    cwd = '~/plugins/',
  }
end

function M.installed_plugins()
  require('telescope.builtin').find_files {
    cwd = vim.fn.stdpath('data') .. '/site/pack/packer/start/'
  }
end

function M.project_search()
  require('telescope.builtin').find_files {
    previewer = false,
    layout_strategy = "vertical",
    cwd = require('nvim_lsp.util').root_pattern(".git")(vim.fn.expand("%:p")),
  }
end

function M.buffers()
  require('telescope.builtin').buffers {
    shorten_path = false,
  }
end

function M.curbuf()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }
  require('telescope.builtin').current_buffer_fuzzy_find(opts)
end

function M.help_tags()
  require('telescope.builtin').help_tags {
    show_version = true,
  }
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end
})
