---@param x number The first argument
---@param y number The argument that comes second
---@param z number Argument coming in final place
local function example_func(x, y, z)
  return x * y + z
end


-- Go to definition: vim.lsp.buf.definition
example_func(1, 2, 3)

-- Signature help
-- example_func(

-- Smart rename
-- function Unused()
--   local example_func = function() return "UNCHANGED" end
--   return example_func
-- end
