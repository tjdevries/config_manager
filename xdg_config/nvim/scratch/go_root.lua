local Path = require('plenary.path')
local _, lspconfig_util = pcall(require, 'lspconfig.util')

GoRootDir = function(fname)
  local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
  print(absolute_cwd)
  local absolute_fname = Path:new(fname):absolute()
  print(absolute_fname)

  if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
    return absolute_cwd
  end

  return lspconfig_util.root_pattern("go.mod", ".git")(fname)
end
