-- Toggle cody chat
vim.keymap.set("n", "<space>cc", function()
  require("sg.cody.commands").toggle()
end)

vim.keymap.set("n", "<space>cn", function()
  local name = vim.fn.input "chat name: "
  require("sg.cody.commands").chat(name)
end)
vim.keymap.set("v", "<space>a", ":CodyContext<CR>")
vim.keymap.set("v", "<space>e", ":CodyExplain<CR>")

vim.keymap.set("n", "<space>ss", function()
  require("sg.extensions.telescope").fuzzy_search_results()
end)

local ok, msg = pcall(require, "sg")
if not ok then
  print("sg failed to load with:", msg)
  return
end

local node_executable = vim.fn.expand "~/.asdf/installs/nodejs/20.4.0/bin/node" --[[@as string]]
require("sg").setup {
  on_attach = require("tj.lsp").on_attach,
  enable_cody = true,
  node_executable = node_executable,
  -- auth_strategy = { "cody-app" },
}

vim.keymap.set({ "n", "i" }, "<M-a>", function()
  require("sg.cody.complete")._preview_completions {
    {
      data = {
        id = "568ea94b-30d9-4c9b-be9f-509d78299eb2",
        insertText = '\tif true {\n\t\treturn log.New(os.DevNull, "[educationalsp]", log.Ldate|log.Ltime|log.Lshort)\n\t}\n',
        range = {
          ["end"] = {
            character = 1,
            line = 164,
          },
          start = {
            character = 0,
            line = 164,
          },
        },
      },
      menu = "[cody]",
      word = 'return log.New(os.DevNull, "[educationalsp]", log.Ldate|log.Ltime|log.Lshort',
    },
  }
end)

if true then
  return
end

if vim.g.dbs == nil then
  vim.g.dbs = vim.empty_dict()
end

local dbs = vim.g.dbs
dbs["sg-local"] = "postgres://sourcegraph:sourcegraph@localhost:5432/sourcegraph"

vim.g.dbs = dbs
