require("luasnip.session.snippet_collection").clear_snippets "go"

local ls = require "luasnip"

local snippet_from_nodes = ls.sn

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local fmt = require("luasnip.extras.fmt").fmt

local ts_locals = require "nvim-treesitter.locals"
local ts_utils = require "nvim-treesitter.ts_utils"

local get_node_text = vim.treesitter.get_node_text

local transforms = {
  int = function(_, _)
    return t "0"
  end,

  bool = function(_, _)
    return t "false"
  end,

  string = function(_, _)
    return t [[""]]
  end,

  error = function(_, info)
    if info then
      info.index = info.index + 1

      return c(info.index, {
        t(info.err_name),
        t(string.format('errors.Wrap(%s, "%s")', info.err_name, info.func_name)),
      })
    else
      return t "err"
    end
  end,

  -- Types with a "*" mean they are pointers, so return nil
  [function(text)
    return string.find(text, "*", 1, true) ~= nil
  end] = function(_, _)
    return t "nil"
  end,
}

local transform = function(text, info)
  local condition_matches = function(condition, ...)
    if type(condition) == "string" then
      return condition == text
    else
      return condition(...)
    end
  end

  for condition, result in pairs(transforms) do
    if condition_matches(condition, text, info) then
      return result(text, info)
    end
  end

  return t(text)
end

local handlers = {
  parameter_list = function(node, info)
    local result = {}

    local count = node:named_child_count()
    for idx = 0, count - 1 do
      local matching_node = node:named_child(idx)
      local type_node = matching_node:field("type")[1]
      table.insert(result, transform(get_node_text(type_node, 0), info))
      if idx ~= count - 1 then
        table.insert(result, t { ", " })
      end
    end

    return result
  end,

  type_identifier = function(node, info)
    local text = get_node_text(node, 0)
    return { transform(text, info) }
  end,
}

local function_node_types = {
  function_declaration = true,
  method_declaration = true,
  func_literal = true,
}

local function go_result_type(info)
  local cursor_node = ts_utils.get_node_at_cursor()
  local scope = ts_locals.get_scope_tree(cursor_node, 0)

  local function_node
  for _, v in ipairs(scope) do
    if function_node_types[v:type()] then
      function_node = v
      break
    end
  end

  if not function_node then
    print "Not inside of a function"
    return t ""
  end

  local query = vim.treesitter.parse_query(
    "go",
    [[
      [
        (method_declaration result: (_) @id)
        (function_declaration result: (_) @id)
        (func_literal result: (_) @id)
      ]
    ]]
  )
  for _, node in query:iter_captures(function_node, 0) do
    if handlers[node:type()] then
      return handlers[node:type()](node, info)
    end
  end
end

local go_ret_vals = function(args)
  return snippet_from_nodes(
    nil,
    go_result_type {
      index = 0,
      err_name = args[1][1],
      func_name = args[2][1],
    }
  )
end

ls.add_snippets("go", {
  s(
    "efi",
    fmta(
      [[
<val>, <err> := <f>(<args>)
if <err_same> != nil {
	return <result>
}
<finish>
]],
      {
        val = i(1),
        err = i(2, "err"),
        f = i(3),
        args = i(4),
        err_same = rep(2),
        result = d(5, go_ret_vals, { 2, 3 }),
        finish = i(0),
      }
    )
  ),
})

-- ls.add_snippets(
--   "go",
--   make {
--     main = {
--       t { "func main() {", "\t" },
--       i(0),
--       t { "", "}" },
--     },
--
--     ef = {
--       i(1, { "val" }),
--       t ", err := ",
--       i(2, { "f" }),
--       t "(",
--       i(3),
--       t ")",
--       i(0),
--     },
--
--     -- TODO: Fix this up so that it actually uses the tree sitter thing
--     ie = { "if err != nil {", "\treturn err", i(0), "}" },
--   }
-- )

-- ls.add_snippets("go", {
--   s("f", fmt("func {}({}) {} {{\n\t{}\n}}", { i(1, "name"), i(2), i(3), i(0) })),
-- })
