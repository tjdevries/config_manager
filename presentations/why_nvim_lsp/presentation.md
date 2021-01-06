---
title: Why did Neovim implement LSP?
author: TJ DeVries (twitch.tv/teej_dv)
date: 2021-01-05
extensions:
  - qrcode
---

# Intro

# Me & LSP

- First Repo: https://github.com/tjdevries/nvim-langserver-shim
    - October 2016
- First Issue: https://github.com/neovim/neovim/issues/5522
    - October 2016
- First PR: https://github.com/neovim/neovim/pull/6856
    - Author: me :)


# Basic Outline

Primary:
1. Precedence: `:help :cscope`
2. LSP is built for editors
3. Justinmk:
> We can have nice things
4. Builtin Extensibility. AKA Make APIs for your editor

Tangential
1. Good practice for Lua standard lib

Future Goals (not promises):
1. Lua development: Batteries included

# FAQs

- Why is it called "builtin"?
- Why build it when `coc.nvim` exists?

# Precedence: `:help :cscope`

While not a popular feature for many, (Neo)vim already ships with
an earlier iteration/idea similar to LSP that was specific for C code.

That feature is `cscope` support and has been builtin for a long time.

LSP is a natural successor to `cscope` since it is language agnostic,
which provides much more benefit to the users.

# LSP is built for editors

LSP is built and designed to do exactly what Neovim did, which is provide
a framework and implementation that allows people to get language smarts
without writing new integrations and plugins for every language.

# `We can have nice things`

Sure, there are other features or things that people could be working on
(although, we got a lot of new contributors because of LSP, so maybe
this isn't a good argument), but LSP is a nice thing for developers to
have the option to use, and Neovim wants to provide users with nice things.


# Builtin Extensibility

I think people are thinking too small when they look at builtin LSP.
It does not have to be a _server_ responding / coordinating messages
inside of Neovim. It can be **any** plugin that wants to use the API.

These APIs are actually defined by the LSP protocol and are independent
of Neovim. Additionally, these APIs will _always_ exist in Neovim, since
it is builtin.

For example:

```lua
vim.lsp.handlers["textDocument/hover"](nil, "textDocument/hover", {
    contents = {
        "this is hovered text",
        "it works exactly the way users want!"
    }
})
```

# Builtin Extensibility

These are building blocks that any plugin can take advantage of and improve on.

The builtin client is not just an implementation, it is also a framework to implement
more integrations, other plugins and useful features for users.

Examples:
- https://github.com/scalameta/nvim-metals
- https://github.com/RishabhRD/nvim-lsputils
- https://github.com/nvim-lua/lsp_extensions.nvim
- (many integrations with FZF)
- (many integrations with Telescope)
- and many more!

# Tangential Benefits

## Good practice for Lua standard library

While implementing LSP, which is a sizeable project that must handle
complexity, maintenance and extensibility, the development team found
many rough edges of our Lua integration and began working on making those
better.

Some examples include:
- Passing Lua closures directly to Vimscript functions
- `vim.wait`
- `vim.highlight`
- (WIP) Lua native autocommands
- ... and more

# Future Goals (not promises):

## Lua Development: builtin, batteries included

One day I would like to make a Lua LSP that's based on a Lua treesitter grammar
and runs in a subprocess of Neovim to give people intelligent linting, completion,
and navigation right out of the box for Neovim & Lua. These kinds of stretch goals
are only possible when we begin to dream bigger about what Neovim can do.

# FAQs

## Why is it called "builtin" if it's implemented all in Lua?

I consider "builtin" to mean that anywhere that I have Neovim,
I will have this thing. For example, I think netrw is often considered builtin,
as well as remote plugin architecture, `checkhealth` and other features that are
not implemented in C, but are implemented in Vimscript or Lua.

As an aside:

Any interface, function or utility useful enough to be written
in C for the LSP implementation inside of Neovim is useful enough
to be exposed with a proper versioning, API, and documentation.

This improves not only the implementation for LSP, but also any
plugin in the Neovim ecosystem.

# FAQs

## Why build this when `coc.nvim`, `vim-lsp`, `etc.` exists?

First off, I often recommend `coc.nvim` to people and will continue
to do so, even after we release a stable version of the builtin LSP client.

We wanted to provide people with the opportunity (not force them, since they don't
have to use builtin LSP) to get the benefits of LSP without having to install other
plugins or dependencies outside of their editor and the requirements for an LSP.

We wanted to provide people with the ability to extend LSP without having to install
other plugins or runtimes and to standardize so that people could enjoy the composability
of many different plugins and configurations.


# Contact Me

- Presentation: https://github.com/tjdevries/config_manager (in presentations)

- Github : https://github.com/tjdevries
- Twitch : https://twitch.tv/teej_dv

```qrcode
https://twitch.tv/teej_dv
```

