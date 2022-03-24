local ls = require "luasnip"

local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  cl = fmt("console.log({});", i(1)),
}
