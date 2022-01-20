local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
for _, dir in ipairs(lua_dirs) do
  dir = string.gsub(dir, "./lua/", "")
  require("plenary.reload").reload_module(dir)
end
