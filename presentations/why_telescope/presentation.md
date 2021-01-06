---
title: Why did you make telescope?
author: TJ DeVries (twitch.tv/teej_dv)
date: 2021-01-05
extensions:
  - qrcode
---

# Intro

https://github.com/nvim-telescope/telescope.nvim

# Reasons

- Fun
- Ease of Use
- Customizability
- "Builtin"

# Fun

I like writing code. I like designing things.

So I made telescope! I didn't expect it to become popular,
I was just goofing around :)

# Ease of Use

```lua
-- ...
    attach_mappings = function(_, map)
      map('i', '<tab>', actions.git_staging_toggle)
      map('n', '<tab>', actions.git_staging_toggle)
      return true
    end
-- ...
    attach_mappings = function()
      actions.goto_file_selection_edit:replace(actions.git_checkout)
      return true
    end
```

# Ease of Use

```lua
finder = finders.new_table {
  results = git_results,
  entry_maker = function(entry)
    local mod, file = get_mod_and_file()
    return {
      value = file,
      status = mod,
      ordinal = entry,
      display = entry,
    }
  end
},
```

# Customizability

```lua
-- Pick different sorting algorithms!
sorter = conf.file_sorter(...)

-- Use different previewers
previewer = previewers.git_commit_diff.new(...)
```

# Customizability

```lua
_ = {
    layout_strategy = 'horizontal',
    layout_defaults = {
      horizontal = {
        width_padding = 0.1,
        height_padding = 0.1,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      }
    },

    selection_strategy = "reset",
    sorting_strategy = "descending",
    scroll_strategy = "cycle",
    prompt_position = "top",
    color_devicons = true,
}
```

# Customizability

```lua
-- ...
mappings = {
  i = {
    ["<c-x>"] = false,
    ["<c-s>"] = actions.goto_file_selection_split,

    -- Experimental
    ["<tab>"] = actions.add_selection,
    ["<c-q>"] = actions.send_to_qflist,
  },
}
```

# "Builtin"

I wanted to be able to use native neovim features.

Files can be loaded in actual neovim buffers. They can
use your colorscheme and even treesitter to do the highlighting!

You can use `nvim_buf_add_highlight` or create your own syntaxes
just the way you would in Neovim to make things pretty.

You can apply highlights to entries.

And so much more!

# "Builtin"

All Lua, all the time

```lua
function M.edit_neovim()
  require('telescope.builtin').find_files {
    prompt_title = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/.config/nvim",
    width = .25,

    layout_strategy = 'horizontal',
    layout_config = {
      preview_width = 0.65,
    },
  }
end
```

# "Builtin"

No temp files, no having to pipe to random processes if you don't wanna :)

# Reasons I stay

The community <3

https://github.com/nvim-telescope

# Contact Me

- Presentation: https://github.com/tjdevries/config_manager (in presentations)

- Github : https://github.com/tjdevries
- Twitch : https://twitch.tv/teej_dv

```qrcode
https://twitch.tv/teej_dv
```
