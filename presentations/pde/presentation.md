---
title: PDE
author: TJ DeVries (twitch.tv/teej_dv)
date: 2022-02-10
---

- TODO: Consider re-recording as a ted talk

# PDE

# Intro

- Who am I?
  - [tjdevries](https://github.com/tjdevries)
  - Neovim core member
  - Telescope.nvim author
- [Twitch](twitch.tv/teej_dv): `teej_dv`
- [YouTube](youtube.com/c/TjDeVries): `TjDeVries`


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

# PDE

## Requirements

- Coding "basics":
  - Syntax highlighting
  - Folding
  - (basically just not Notepad...)
- Code Intelligence
  - For example: LSP
  - (Can be builtin or plugin)

# PDE

## Requirements

- Coding "basics":
  - Syntax highlighting
  - Folding
  - (basically just not Notepad...)
- Code Intelligence
  - For example: LSP
  - (Can be builtin or plugin)
- PDE provides:
  - Composition of tools
  - Scriptable & Extensible

# PDE

## Requirements

- YOU ARE HAVING FUN!

_side rant about "faster" as an argument for a tool_


# Neovim as PDE

It can do syntax highlighting, folding, movements, editing files, etc.

I don't think that's really contested by anyone, not even the `ackshually` crowd.

# Neovim as PDE

- API
  - Exposes robust api (`:help api`)

```lua
vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    "First Line",
    "Second Line"
})
```

# Neovim as PDE

- Lua-ify Everything
  - Settings
  - Keymaps
  - Commands
  - Autocmds (soon)
  - etc.

Scripting is configuration. Configuration is scripting.

# Neovim as PDE

- Treesitter
  - Syntax highlighting
  - But so much more than syntax highlighting!

# Neovim as PDE

- Builtin LSP

# Neovim as PDE

- nvim-dap
- vimspector
