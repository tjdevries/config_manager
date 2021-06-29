-- Used to run stylua automatically if in a lua file
-- and the file "stylua.toml" exists in the base root of the repo.
--
-- Otherwise doesn't do anything.

vim.api.nvim_exec([[
  augroup StyluaAuto
    autocmd BufWritePre *.lua :lua require("tj.stylua").format()
  augroup END
]], false)
