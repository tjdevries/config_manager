local ls = require "luasnip"

local snippet = ls.s
local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node

local shortcut = function(val)
  if type(val) == "string" then
    return { t { val }, i(0) }
  end

  if type(val) == "table" then
    for k, v in ipairs(val) do
      if type(v) == "string" then
        val[k] = t { v }
      end
    end
  end

  return val
end

local M = {}

M.same = function(index)
  return f(function(args)
    return args[1]
  end, { index })
end

M.make = function(tbl)
  local result = {}
  for k, v in pairs(tbl) do
    table.insert(result, (snippet({ trig = k, desc = v.desc }, shortcut(v))))
  end

  return result
end

return M
