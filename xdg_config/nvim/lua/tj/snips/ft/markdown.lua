require("luasnip.session.snippet_collection").clear_snippets "markdown"

local ls = require "luasnip"

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep

ls.add_snippets("markdown", {
  s("t", fmt("- [{}] {}", { c(2, { t " ", t "-", t "x" }), i(1, "task") })),
})
