require("luasnip.session.snippet_collection").clear_snippets "elixir"

local ls = require "luasnip"

local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local s = ls.snippet
local c = ls.choice_node
local d = ls.dynamic_node
local i = ls.insert_node
local t = ls.text_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("elixir", {
  s("el", fmt("<%= {} %>{}", { i(1), i(0) })),
  s("ei", fmt("<%= if {} do %>{}<% end %>{}", { i(1), i(2), i(0) })),
})
