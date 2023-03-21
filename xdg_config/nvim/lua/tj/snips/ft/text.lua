require("luasnip.session.snippet_collection").clear_snippets "text"

local ls = require "luasnip"

local s = ls.s
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

ls.add_snippets("text", {
  s(
    "ts.test",
    fmta(
      [[
================================================================================
<name>
================================================================================

<input>

--------------------------------------------------------------------------------

()
]],
      {
        name = i(1),
        input = i(2),
      }
    )
  ),
})
