local bufnr = 0
local win = 0

local langtree = vim.treesitter.get_parser(bufnr)
local cursor = vim.api.nvim_win_get_cursor(win)
local range = {
  cursor[1],
  cursor[2],
  cursor[1],
  cursor[2],
}
local current_tree = langtree:language_for_range(range)
local lang = current_tree:lang()
print("Lang is:", lang)

P(current_tree:trees()[1]:root())
-- tsnode:named_descendant_for_range({start_row}, {start_col}, {end_row}, {end_col})
local named_descendant = current_tree:trees()[1]:root():named_descendant_for_range(4, 6, 4, 55)
P(named_descendant:type())

--P(ts_utils.get_node_text(current_node, bufnr))
--local get_language

-----@class LanguageTree
-----@field contains function
-----@field children function
-----@field lang function

----- Get the language for a range
-----@param parser LanguageTree: The current parser
-----@param range table: The range of a table
--get_language = function(parser, range)
--  if not parser:contains(range) then
--    return nil
--  end

--  for _, child in pairs(parser:children()) do
--    if child:contains(range) then
--      return get_language(child, range)
--    end
--  end

--  return parser:lang()
--end

--print("Lang:", get_language(langtree, { current_node:range() }))
--print("Lang:", langtree:language_for_range({ current_node:range() }):lang())
