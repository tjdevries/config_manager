-- Toggle cody chat
vim.keymap.set("n", "<space>cc", require("sg.cody.commands").toggle)
vim.keymap.set("n", "<space>cn", function()
  local name = vim.fn.input "chat name: "
  require("sg.cody.commands").chat(name)
end)
vim.keymap.set("v", "<space>a", ":CodyContext<CR>")
vim.keymap.set("v", "<space>e", ":CodyExplain<CR>")

if true then
  return
end

local ok, msg = pcall(require, "sg")
if not ok then
  print("sg failed to load with:", msg)
  return
end

if vim.g.dbs == nil then
  vim.g.dbs = vim.empty_dict()
end

local dbs = vim.g.dbs
dbs["sg-local"] = "postgres://sourcegraph:sourcegraph@localhost:5432/sourcegraph"

vim.g.dbs = dbs

require("sg").setup {
  on_attach = require("tj.lsp").on_attach,
}
