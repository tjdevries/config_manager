if vim.g.dbs == nil then
  vim.g.dbs = vim.empty_dict()
end

local dbs = vim.g.dbs
dbs["sg-local"] = "postgres://sourcegraph:sourcegraph@localhost:5432/sourcegraph"

vim.g.dbs = dbs
