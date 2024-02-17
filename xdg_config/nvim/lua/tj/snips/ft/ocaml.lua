require("luasnip.session.snippet_collection").clear_snippets "ocaml"

local ls = require "luasnip"
local s = ls.s
local t = ls.t
local i = ls.i
local f = ls.f
local d = ls.d
local sn = ls.sn

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local events = require "luasnip.util.events"

-- module RPS = struct
--   type t = Rock | Paper | Scissors
--
--   let of_string = function
--     | "A" -> Rock
--     | "B" -> Paper
--     | "C" -> Scissors
--     | _ -> assert false
--
--   let to_string = function
--     | Rock -> "A"
--     | Paper -> "B"
--     | Scissors -> "C"
--
--   let compare a b = compare (to_string a) (to_string b)
-- end

ls.add_snippets("ocaml", {
  s(
    "example",
    fmt("let {third} = {rep} {name}", {
      rep = f(function(args)
        return tostring(#(args[1][1] or "")) .. " | " .. vim.api.nvim_buf_get_name(0)
      end, { 1 }),
      name = i(1, "name"),
      third = i(2),
    })
  ),
  s(
    "smod",
    fmt(
      [[module {name} = struct
  type t = {patterns}

  let of_string = function
{rules}

  let compare a b = compare (to_string a) (to_string b)
end]],
      {
        name = i(1),
        patterns = i(2),
        rules = d(3, function(args)
          local patterns = args[1][1]

          local units = vim.split(patterns, "|")
          units = vim.tbl_map(function(v)
            return vim.trim(v)
          end, units)

          units = vim.tbl_filter(function(v)
            return v ~= ""
          end, units)

          local snips = {}

          -- of string
          for idx, v in ipairs(units) do
            table.insert(snips, t '    | "')
            table.insert(snips, i(idx, v))
            table.insert(snips, t('" -> ' .. v))
            table.insert(snips, t { "", "" })
          end

          -- fallthrough case
          table.insert(snips, t { "    | _ -> assert false", "" })

          -- to_string
          table.insert(snips, t { "", "  let to_string = function", "" })

          for idx, v in ipairs(units) do
            table.insert(snips, t("    | " .. v .. ' -> "'))
            table.insert(snips, rep(idx))
            table.insert(snips, t { '"', "" })
          end

          return sn(nil, snips)
        end, { 2 }),
      }
    ),
    {
      callbacks = {
        [-1] = {
          [events.enter] = function()
            require("cmp.config").set_buffer({
              enabled = false,
            }, vim.api.nvim_get_current_buf())
          end,
          [events.leave] = function()
            require("cmp.config").set_buffer({
              enabled = true,
            }, vim.api.nvim_get_current_buf())
          end,
        },
      },
    }
  ),
  -- It's annoying to type the comment syntax.
  -- Let's not do that anymore
  s({
    trig = "//",
    snippetType = "autosnippet",
  }, { t "(* ", i(1), t " *)", i(0) }),

  s("expect", fmt('let%expect_test "{}" =\n  {}\n  [%expect {{||}}]\n', { i(1), i(0) })),
})

local riot_loggers = {}
for _, name in ipairs { "error", "warn", "info", "debug", "trace" } do
  -- info (fun f -> f "i(1)"))i(0)
  table.insert(riot_loggers, s(name, fmt(string.format('%s (fun f -> f "{}"){}', name), { i(1), i(0) })))
end

ls.add_snippets("ocaml", riot_loggers)
