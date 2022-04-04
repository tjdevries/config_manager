---
title: Neovim as PDE
author: TJ DeVries (twitch.tv/teej_dv)
date: 2022-02-10
---

# Neovim As PDE

# Intro

- Who am I?
  - [tjdevries](https://github.com/tjdevries)
  - Neovim core member
  - Telescope.nvim author
- [Twitch](twitch.tv/teej_dv)
- [YouTube](youtube.com/c/TjDeVries)

# PDE?

Partial Differential Equation?

# PDE?

Personalized Development Environment


# PDE

> Text Editor <-> IDE

- The above seems like too limited of a spectrum.
- It seems to confuse people (especially those who have never tried something like neovim) as to what the purpose would be of using them.

# PDE

> Text Editor <-> PDE <-> IDE

Something in between Text Editor and IDE I think could be useful to add to our vocabulary

# PDE

## Requirements

> Some assembly required

# PDE

## Requirements

- Coding "basics":
  - Syntax highlighting
  - Folding
  - (basically just not Notepad...)
- Code Intelligence
  - For example: LSP
  - (Can be builtin or plugin)
- Focus:
  - Composition of tools
  - Scriptable & Extensible

# PDE

## Requirements

- YOU ARE HAVING FUN!

_side rant about "faster" as an argument for a tool_

# Neovim

## Main Selling Points

> It's Vim!

Neovim is a fork of Vim.
- Still merges upstream patches/tests from Vim
- Same old `:help` you know and love
- Existing plugins still work (mostly)!

Doesn't have "Vim Emulator" problems.

# Neovim

## Main Selling Points

> It's **not** Vim!

- Willing to change some conventions to better future users.
  - `$XDG_CONFIG_HOME` setup.
  - Different defaults, by default.
  - Different default mappings, `nmap Y y$` is default

> Behaviors, options, documentation are removed if they cost users more time than they save.

# Neovim

## Main Selling Points

> It's not Vim!

- Neovim has different goals than Vim
  - Always built with all features
  - Remote API
  - GUIs are plugins
- Lua as primary scripting language
  - Including LibUV bindings


# Neovim

## Main Selling Points

- API
  - Exposes robust api (`:help api`)

```lua
vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    "First Line",
    "Second Line"
})
```

# Neovim

## Main Selling Points

- Lua-ify Everything
  - Settings
  - Keymaps
  - Commands
  - Autocmds (soon)
  - etc.

# Neovim

## Main Selling Points

- Treesitter
  - Syntax highlighting
  - "Industry" technology
    - Not just for vim
  - But so much more than syntax highlighting!

# Neovim

## Main Selling Points

- Builtin LSP

# Live Demo

- Treesitter
  - Playground
  - Incremental Selection
  - TS Hint
  - Text Objects
    - Movement
    - Deletion
    - Swap
  - Snippets
- LSP
  - Definition
  - Rename
  - References
  - Running Tests
- DAP
  - ...
- Fuzzy Finding (#ad)
  - Files
  - Grep

- Q&A

