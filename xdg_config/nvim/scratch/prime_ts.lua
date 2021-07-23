local bufnr = 25

local query = vim.treesitter.get_query("go", "locals")
P(query)

local parser = vim.treesitter.get_parser(bufnr, "go")
local tree = parser:parse()[1]
P(tree)

for id, node, md in query:iter_captures(tree:root(), bufnr, 0, -1) do
  print(query.captures[id])
end
