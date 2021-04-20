local Path = require('plenary.path')
local Job = require('plenary.job')

local lspconfig_util = require('lspconfig.util')

local stylua_finder = lspconfig_util.root_pattern('stylua.toml')

local stylua = {}

stylua.format = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local filepath = Path:new(vim.api.nvim_buf_get_name(bufnr)):absolute()
  local stylua_toml = stylua_finder(filepath)

  if not stylua_toml then
    return
  end


  local output = Job:new {
    "stylua", "-",
    writer = vim.api.nvim_buf_get_lines(0, 0, -1, false),
  }:sync()

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)
end

return stylua
