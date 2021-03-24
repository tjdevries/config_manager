# Lua Generally

Season 1: How to Lua

- Mechanism
    - scoping rules, basic syntax
    - functions
    - tables
        - metatables
        - indexing at 1
    - modules
        - package.loaded
        - package.*
        - require
    - string syntax, and literal function calls
        - How you can imitate keyword arguments using literal syntax

- Philosophy
    - Why doesn't it ship with a lot of stuff


# Neovim Specific

Seaons 2: How to neovim lua

- what the heck were you thinking with choosing Lua??
- what the heck is this global `vim` for??
- `vim.fn` vs. `vim.api`
    - vim.fn <- lua -> vimscript -> C -> vimscript -> lua
    - vim.api <- lua -> C -> lua

    - vim.schedule & ":help api-fast"
        - sometimes neovim's global state can't execute certain actions
            - Like... we're processing an edit. You can't do ANOTHER edit at the same time.
            - So, you can schedule things for later, when you're allowed to do that.
- extmarks



~~~~~

How to contribute to OSS (as an OSS GITHUB STAR MILLIONAIRRREE)
    - configuring / setting up project
    - linting
    - testing

~~~~~

Set up doing the viewer event once a month
- twitch tos for this kind of stuff...?
