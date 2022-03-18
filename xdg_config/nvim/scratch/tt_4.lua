local ls = require "luasnip"

-- Preamble: Refer to LuaSnip 1
local s, i, t = ls.s, ls.insert_node, ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

-- This a choice snippet. You can move through with <c-l> (in my config)
--   c(1, { t {"hello"}, t {"world"}, }),
--
-- The first argument is the jump position
-- The second argument is a table of possible nodes.
--  Note, one thing that's nice is you don't have to include
--  the jump position for nodes that normally require one (can be nil)
local c = ls.choice_node

-- This is a function node. You can calculate the snippet result.
--
-- The first argument is a function that takes a list of args.
-- Function nodes always return a string to insert
local f = ls.function_node

local same = function(index)
  return f(function(arg)
    return arg[1]
  end, { index })
end

--
--
--
--
--
--
--
--

-- Snippet Node
local sn = ls.sn
local d = ls.dynamic_node

local get_test_result = function(position)
  -- TODO:
  return d(position, function()
    local nodes = {}
    table.insert(nodes, t " ")
    table.insert(nodes, t " -> Result<(), MyError> ")

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
      if line:match "anyhow::Result" then
        table.insert(nodes, t " -> Result<()> ")
        break
      end
    end

    return sn(nil, c(1, nodes))
  end, {})
end

--
--
--
--
--

--

ls.snippets = {
  lua = {
    -- local builtin = require "telescope.pickers.builtin"
    -- local telescope.builtin.whatever = require "telescope.builtin.whatever"
    -- local telescope.builtin = require "telescope.builtin"
    s(
      "req",
      fmt([[local {} = require "{}"]], {
        f(function(import_name)
          local parts = vim.split(import_name[1][1], ".", true)
          return parts[#parts] or ""
        end, { 1 }),
        i(1),
      })
    ),
  },
  all = {
    s("sametest", fmt([[example: {}, function: {}]], { i(1), same(1) })),
    s(
      "curtime",
      f(function()
        return os.date "%D - %H:%M"
      end)
    ),

    s("todo", {
      c(1, {
        t "TODO(tjdevries): ",
        t "FIXME(tjdevries): ",
        t "TODONT(tjdevries): ",
        t "TODO(anybody please help me): ",
      }),
    }),
  },

  -- Rust Only
  rust = {
    -- Rust: Adding a test module
    s(
      "modtest",
      fmt(
        [[
                  #[cfg(test)]
                  mod test {{
                  {}

                      {}
                  }}
                ]],
        {
          c(1, { t "    use super::*;", t "" }),
          i(0),
        }
      )
    ),

    -- Rust: Adding a test case
    s(
      "test",
      fmt(
        [[
          #[test]
          fn {}(){}{{
              {}
          }}
        ]],
        {
          i(1, "testname"),
          get_test_result(2),
          i(0),
        }
      )
    ),
  },
}
