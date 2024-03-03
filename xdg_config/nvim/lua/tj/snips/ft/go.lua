-- This clears my go snippets, so when I source this file
-- I can try the snippets again, without restarting neovim.
--
-- This is pretty useful if you're trying to do something a bit
-- more complicated or just exploring random snippet ideas
require("luasnip.session.snippet_collection").clear_snippets "go"

local ls = require "luasnip"

local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local s = ls.snippet
local c = ls.choice_node
local d = ls.dynamic_node
local i = ls.insert_node
local t = ls.text_node
local sn = ls.snippet_node

-- Map of default values for types.
--  Some have a bit more complicated default values,
--  but that's OK :) Lua is flexible enough!
local default_values = {
  int = "0",
  bool = "false",
  string = '""',

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

  -- Convention: Usually no "*" and Capital is a struct type, so give the option
  -- to have it be with {} as well.
  [function(text)
    return not string.find(text, "*", 1, true) and string.upper(string.sub(text, 1, 1)) == string.sub(text, 1, 1)
  end] = function(text, info)
    info.index = info.index + 1

    return c(info.index, {
      t(text .. "{}"),
      t(text),
    })
  end,
}

--- Transforms some text into a snippet node
---@param text string
---@param info table
local transform = function(text, info)
  --- Determines whether the key matches the condition
  local condition_matches = function(condition, ...)
    if type(condition) == "string" then
      return condition == text
    else
      return condition(...)
    end
  end

  -- Find the matching condition to get the correct default value
  for condition, result in pairs(default_values) do
    if condition_matches(condition, text, info) then
      if type(result) == "string" then
        return t(result)
      else
        return result(text, info)
      end
    end
  end

  -- If no matches are found, just return the text, can fix up easily
  return t(text)
end

-- Maps a node type to a handler function.
local handlers = {
  parameter_list = function(node, info)
    local result = {}

    local count = node:named_child_count()
    for idx = 0, count - 1 do
      local matching_node = node:named_child(idx)
      local type_node = matching_node:field("type")[1]
      table.insert(result, transform(vim.treesitter.get_node_text(type_node, 0), info))
      if idx ~= count - 1 then
        table.insert(result, t { ", " })
      end
    end

    return result
  end,

  type_identifier = function(node, info)
    local text = vim.treesitter.get_node_text(node, 0)
    return { transform(text, info) }
  end,
}

--- Gets the corresponding result type based on the
--- current function context of the cursor.
---@param info table
local function go_result_type(info)
  local function_node_types = {
    function_declaration = true,
    method_declaration = true,
    func_literal = true,
  }

  -- Find the first function node that's a parent of the cursor
  local node = vim.treesitter.get_node()
  while node ~= nil do
    if function_node_types[node:type()] then
      break
    end

    node = node:parent()
  end

  -- Exit if no match
  if not node then
    vim.notify "Not inside of a function"
    return t ""
  end

  -- This file is in `queries/go/return-snippet.scm`
  local query = assert(vim.treesitter.query.get("go", "return-snippet"), "No query")
  for _, capture in query:iter_captures(node, 0) do
    if handlers[capture:type()] then
      return handlers[capture:type()](capture, info)
    end
  end
end

local go_return_values = function(args)
  return sn(
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
        result = d(5, go_return_values, { 2, 3 }),
        finish = i(0),
      }
    )
  ),
  s("ie", fmta("if err != nil {\n\treturn <err>\n}", { err = i(1, "err") })),
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
