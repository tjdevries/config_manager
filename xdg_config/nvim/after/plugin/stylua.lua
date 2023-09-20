-- Used to run stylua automatically if in a lua file
-- and the file "stylua.toml" exists in the base root of the repo.
--
-- Otherwise doesn't do anything.

if vim.fn.executable "stylua" == 0 or true then
  return
end

vim.cmd [[
  augroup StyluaAuto
    au!
    autocmd BufWritePre *.lua :lua require("tj.stylua").format()
  augroup END
]]
