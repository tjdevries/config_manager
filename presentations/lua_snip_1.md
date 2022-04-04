# Video 1 - Getting  Start

- Explain what a snippet is.
- Show two example snippets:
  - one really simple one (like expanding a func -> func()\n{...}
  - tree sitter one, to motivate where we could end up.
- keymaps
  - explain keymaps
  - vim.keymap style would be cool
- basic options
- Adding snippets:
  - Show simple text snippets
    - lsp.parse
    - `TM_FILENAME` expansions
  - Create your own lua snippets
    - `s("trigger", {nodes...})`
      - Text Node
      - Insert Node
    - fmt("...", { nodes...})

Outro: https://www.youtube.com/results?search_query=angry+kylo+ren
Outro: https://www.youtube.com/watch?v=grtJjUmkJmk

-----------------------------------

# Video 2 - Advanced Features

- function nodes
- choice nodes
- snippet nodes
- dynamic node

```lua
-- in a lua file: search lua-, then c-, then all-snippets.
ls.filetype_extend("lua", { "c" })

-- in a cpp file: search c-snippets, then all-snippets only (no cpp-snippets!!).
ls.filetype_set("cpp", { "c" })
```

# Video 3 - Show off how cool it can be

- treesitter based golang snippet
- $$ (.*) snippet


# Notes
- luasnip telescope integ: https://github.com/benfowler/telescope-luasnip.nvim || https://github.com/abzcoding/lvim/tree/main/lua/telescope/_extensions
