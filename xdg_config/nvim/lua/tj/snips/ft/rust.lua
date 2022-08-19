local ls = require "luasnip"
local snippet_collection = require "luasnip.session.snippet_collection"

-- local snippet = ls.s
-- local snippet_from_nodes = ls.sn

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
-- local d = ls.dynamic_node
local c = ls.choice_node
-- local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local shared = R "tj.snips"
local same = shared.same

-- ls.cl
snippet_collection.clear_snippets "rust"
ls.add_snippets("rust", {
  s(
    "tmain",
    fmt(
      [[
#[tokio::main]
async fn main() -> anyhow::Result<()> {{
  Ok(())
}}]],
      {}
    )
  ),

  s(
    "yew_comp",
    fmt(
      [[use yew::prelude::*;

#[derive(Clone, PartialEq, Properties)]
pub struct {}Props {{}}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum {}Msg {{}}

pub struct {} {{}}

impl Component for {} {{
  type Message = {}Msg;
  type Properties = {}Props;

  fn create(ctx: &Context<Self>) -> Self {{
      Self {{}}
  }}

  fn view(&self, ctx: &Context<Self>) -> Html {{
    todo!()
  }}
}}
]],
      {
        same(1),
        same(1),
        same(1),
        i(1),
        same(1),
        same(1),
      }
    )
  ),

  s(
    "main",
    fmt(
      [[
    fn main() {{
    }}
    ]],
      {}
    )
  ),
  s(
    "modtest",
    fmt(
      [[
      #[cfg(test)]
      mod test {{
          use super::*;

          {}
      }}
    ]],
      i(0)
    )
  ),
  s(
    { trig = "test" },
    fmt(
      [[
  #[test]
  fn {}(){}{{
    {}
  }}
  ]],
      {
        i(1, "testname"),
        c(2, {
          t "",
          t " -> Result<()> ",
          -- fmt(" -> {}<()> ", { i(nil, "Result") }),
        }),
        i(0),
      }
    )
  ),
  s("eq", fmt("assert_eq!({}, {});{}", { i(1), i(2), i(0) })),
  s("enum", {
    t { "#[derive(Debug, PartialEq)]", "enum " },
    i(1, "Name"),
    t { " {", "  " },
    i(0),
    t { "", "}" },
  }),

  s("struct", {
    t { "#[derive(Debug, PartialEq)]", "struct " },
    i(1, "Name"),
    t { " {", "    " },
    i(0),
    t { "", "}" },
  }),

  s("pd", fmt([[println!("{}: {{:?}}", {});]], { same(1), i(1) })),
  -- _pd = {
  --   t [[println!("{:?}", ]],
  --   i(1),
  --   t [[);]],
  -- },
})
