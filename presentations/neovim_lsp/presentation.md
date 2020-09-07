---
title: Neovim & LSP
author: TJ DeVries (twitch.tv/teej_dv)
date: 2020-09-06
extensions:
  - qrcode
---


# What is LSP?

Language Server Protocol

> The Language Server Protocol (LSP) defines the protocol used between an editor or IDE and
> a language server that provides language features like auto complete, go to definition, find all references etc.

Created in June, 2016 by Microsoft in collaboration with Red Hat and Codenvy

# Why is it exciting?

It is one method of trying to make a large `M x N` problem into a `M + N` problem.

- `M` editors


- `N` languages

# How does it work?

Client: Any editor that supports LSP

Server: Any LSP Server providing information about a language

```
    Send request:

        +--------------+      +--------------+
        |              |----->|              |
        |    Client    |      |    Server    |
        |              |      |              |
        +--------------+      +--------------+

    Get response

        +--------------+      +--------------+
        |              |      |              |
        |    Client    |      |    Server    |
        |              |<-----|              |
        +--------------+      +--------------+
```

# How does it work?

Client: This is Neovim.
- It runs a server that handles communication with servers (can run multiple)
    - Configures server and capabilities (e.g. "Can the client and server both do snippets?)
    - Sends requests & handles responses (e.g. Go-to-definition)
    - Handles notifications sent by server (e.g. Diagnostics)
- Determine what to do with each response.


# How does it work?

Server: Something that communicates with the client! (as simple as that :smile:)


This slide is here just as a reminder, when you're getting started, you will need to _install_ the language servers you want to use.
- Neovim ships with a **client**, not with servers.


# Me & LSP

- First Repo: https://github.com/tjdevries/nvim-langserver-shim
    - October 2016
    - @prabirshrestha worked quite a bit w/ me.
        - Prabir was working on this as well: https://github.com/prabirshrestha/vim-lsp

# Neovim & LSP

- First Issue: https://github.com/neovim/neovim/issues/5522
    - October 2016


- First PR: https://github.com/neovim/neovim/pull/6856
    - Author: me :)


- Second PR: https://github.com/neovim/neovim/pull/10222
    - Author: The wonderful and incredibly nice @h-michael


- "Final" PR: https://github.com/neovim/neovim/pull/11336
    - Author: The astonishgly productive and effective @norcalli
    - November 2019
    - Diff: `+5,556 -1`

# Neovim & LSP

I only put "Final" because now we've had so many great contributors help on LSP PRs!

> git log --pretty=format:"%an%x09" runtime/lua/vim/lsp | sort | uniq

Alvaro Muñoz

Alvaro Muñoz

Andreas Johansson

Andrey Avramenko

Andy Lindeman

Anmol Sethi

Ashkan Kiani

Björn Linse

Blaž Hrastnik

cbarrete

Cédric Barreteau

Chris Kipp

Christian Clason

ckipp01

David Lukes

Dheepak Krishnamurthy

Eisuke Kawashima

francisco souza

Gabriel Sanches

George  Zhao

Ghjuvan Lacambre

Gıyaseddin Tanrıkulu

Hirokazu Hata

jakbyte

Jakub Łuczyński

Jesse

Jesse Bakker

Jesse-Bakker

Justin M. Keyes

Khangal

landerlo

Mathias Fussenegger

Mathias Fußenegger

Matthieu Coudron

Mike Hartington

Patrice Peterson

Stephan Seitz

Thore Weilbier

TJ DeVries

Viktor Kojouharov

Ville Hakulinen

Yen3

# Other Great Projects

- LanguageClient: https://github.com/autozimu/LanguageClient-neovim
- CoC.nvim: https://github.com/neoclide/coc.nvim
- vim-lsc: https://github.com/natebosch/vim-lsc
- YCM: https://github.com/ycm-core/YouCompleteMe
- vim-lsp (as I've mentioned above)

# Why builtin?

- Already some precedent `:help :cscope` and friends.
- Easier to support new features, since only one version of nvim must be supported
- Provides building blocks that anyone can use -- not just LSP integration


# Getting started with builtin LSP

I recommend looking here: https://github.com/neovim/nvim-lspconfig

Can really help getting started with some servers!

```lua
require'nvim_lsp'.gopls.setup{}
```

# Getting started with builtin LSP

But sometimes the defaults could use to be customized for you!

```lua
nvim_lsp.sumneko_lua.setup({
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
      completion = { keywordSnippet = "Disable", },
      diagnostics = { enable = true, globals = {
        "vim", "describe", "it", "before_each", "after_each" }),
      },
      workspace = {
        library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("~/build/neovim/src/nvim/lua")] = true,
          },
        ),
      },
    }
  },
  ...
})
```

# Getting started with builtin LSP

/rant -- `nvim-lspconfig` is not where the actual functionality is implemented.

# Getting started with builtin LSP

## Using `on_attach`

```lua
nvim_lsp.pyls.setup({
  enable = true,
  plugins = {
    pyls_mypy = {
      enabled = true,
      live_mode = false
    }
  },
  on_attach = custom_attach
})
```

# Getting started with builtin LSP

## Using `on_attach`

```lua
local mapper = function(mode, key, result)
  vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

local custom_attach = function(client)
  mapper('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
  mapper('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')

  mapper('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  mapper('n', '<space>cr', '<cmd>lua vim.lsp.buf.rename()<CR>')

  if vim.api.nvim_buf_get_option(0, 'filetype') == 'rust' then
    vim.cmd [[autocmd BufEnter,BufWritePost <buffer> ]] ..
               [[:lua require('lsp_extensions.inlay_hints').request ]] ..
                  [[{ aligned = true, prefix = " » " }]]
  end

  vim.cmd("setlocal omnifunc=v:lua.vim.lsp.omnifunc")
end
```

# Getting started with builtin LSP

## Using `on_attach`


Normal mode mapping to `K` that makes help text `hover` at your cursor.

```lua
mapper('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
```

Go to definition using `<c-]>`

```lua
mapper('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
```

NOTE: I recommend using mappings for LSP that align with general "vim" ways of doing things.

# Getting started with builtin LSP

## `vim.lsp.buf` is your friend

Check out `:help vim.lsp.buf.<TAB>` to see many of the builtin features.

Some of the ones I love:
- `vim.lsp.buf.hover()`
- `vim.lsp.buf.definition()`
- `vim.lsp.buf.code_action()`
- `vim.lsp.buf.rename()`
- `vim.lsp.buf.signature_help()`

# Getting started with builtin LSP

## `vim.lsp.util` is your friend as well

Some helpful utilities:
- `vim.lsp.util.make_*`
- `vim.lsp.util.jump_to_location()`
- `vim.lsp.util.show_line_diagnostics()`

# Builtin LSP Goals

# Builtin LSP Goals

- Lightweight
- Extensible
- Customizable
- Re-usable


# Builtin LSP Goals

## Lightweight

```
➜ cloc runtime/lua/vim/lsp.lua runtime/lua/vim/lsp/
       7 text files.
       7 unique files.                              
       0 files ignored.

github.com/AlDanial/cloc v 1.82  T=0.05 s (147.3 files/s, 106777.6 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
Lua                              7            354           1980           2742
-------------------------------------------------------------------------------
SUM:                             7            354           1980           2742
-------------------------------------------------------------------------------
```

# Builtin LSP Goals

## Extensible

Let's walk through a short & simple example of how you can extend LSP.

# textDocument/definition Example

[textDocument/definition](https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_definition)

Request:

```lua
-- TextDocumentPositionParams
params = {
    -- TextDocumentIdentifier
    textDocument = {
        uri = "file:///home/tj/example/file.lua",
    },

    -- Position
    position = {
        line = 13,
        character = 12,
    },
}
```

# textDocument/definition Example

Send request to server

# textDocument/definition Example

Response:

```lua
response = {
    uri = "file:///home/tj/example/definition.lua",
    range = {
        ['start'] = {
            line = 1,
            character = 3,
        },
        ['end'] = {
            line = 1,
            character = 12,
        }
    }
}
```

# textDocument/definition Example

This is similar to the builtin callback by default for `textDocument/definition`

```lua
local function location_callback(_error, _method, result)
  -- ... error handling ...

  if vim.tbl_islist(result) then
    util.jump_to_location(result[1])

    if #result > 1 then
      util.set_qflist(util.locations_to_items(result))
      api.nvim_command("copen")
      api.nvim_command("wincmd p")
    end
  else
    util.jump_to_location(result)
  end
end

vim.lsp.callbacks['textDocument/definition'] = location_callback
```

# textDocument/definition Example

```lua
local function location_callback(_error, _method, result)
  -- ... error handling ...

  if vim.tbl_islist(result) then
    util.jump_to_location(result[1])

    if #result > 1 then
      util.set_qflist(util.locations_to_items(result))
      -- api.nvim_command("copen")
      -- api.nvim_command("wincmd p")
    end
  else
    util.jump_to_location(result)
  end
end

vim.lsp.callbacks['textDocument/definition'] = location_callback
```

# Live Demo: Rust Inlay

- `inlayHints`
    - customize behavior!


Implemenation: https://github.com/tjdevries/lsp_extensions.nvim

NOTE: Can show implementation if chat is interested


# Customizable

- We don't want to cover every scenario in core

> Strong opinions, easily overridable
>
> - bjorn & justin

# Live Demo: Use Telescope.nvim instead of Quickfix

- `workspace/symbol`

# Re-usable

Let's look at the source!

# Evidence we're on the right track:

Example of extending builtin features:

- https://github.com/nvim-lua/completion-nvim
- https://github.com/nvim-lua/diagnostic-nvim
- https://github.com/nvim-lua/lsp-status.nvim

Example of powerful language setup:

- https://github.com/scalameta/nvim-metals

# Contact Me

- Presentation: https://github.com/tjdevries/config_manager (in presentations)

- Github : https://github.com/tjdevries
- Twitch : https://twitch.tv/teej_dv

```qrcode
https://twitch.tv/teej_dv
```

