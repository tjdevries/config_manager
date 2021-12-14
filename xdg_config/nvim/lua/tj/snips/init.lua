local ls = require "luasnip"

local f = ls.function_node

local M = {}

M.same = function(index)
  return f(function(args)
    return args[1]
  end, { index })
end

return M
