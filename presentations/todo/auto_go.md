Someone asked me how did I do this $CLIP in one of my recent videos.
I'm going to walk you through how easy it is to do and to show you
that on the fly scripting for nvim can give you lots of cool results!

```lua

local bufnr = 0
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "line number 1", "the next line" })
```

then show how to run something

```lua
-- I use plenary, cause it makes things easier. If you have telescope, then you've installed plenary
local Job = require "plenary.job"

Job:start {
  "go", "run", "main.go",
  on_exit = function(...)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "main.go output:" })
    vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, output)
  end,
}
```

then just source that file. you'll see it run.

Now, you just need an autocmd


```lua

local Job = require "plenary.job"

local group = vim.api.nvim_create_augroup(...)
vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    buffer = bufnr,
    callback = function()
      Job:start {
        "go", "run", "main.go",
        on_exit = function(...)
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "main.go output:" })
          vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, output)
        end,
      }
    end,
  })

```

Run this and you're all set. You can do the same with a test runner, set it to only do that for certain file paths,
    wahtever. It's all up to you and your own... personalized development environment!


And remember, if you're doing this often, that means that you could just save this as a function for yourself
later and then easily do this for different patterns, for input patterns (via vim.fn.input for example) and more!
Don't forget that Lua is a programming language, not just a configuration setup for nvim :)
