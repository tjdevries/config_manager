local Path = require "plenary.path"
local Job = require "plenary.job"

local lspconfig_util = require "lspconfig.util"

local cached_configs = {}

local root_finder = lspconfig_util.root_pattern ".git"
local stylua_finder = function(path)
  if cached_configs[path] == nil then
    local file_path = Path:new(path)
    local root_path = Path:new(root_finder(path))

    local file_parents = file_path:parents()
    local root_parents = root_path:parents()

    local relative_diff = #file_parents - #root_parents
    for index, dir in ipairs(file_parents) do
      if index > relative_diff then
        break
      end

      local stylua_path = Path:new { dir, "stylua.toml" }
      if stylua_path:exists() then
        cached_configs[path] = stylua_path:absolute()
        break
      end
    end
  end

  return cached_configs[path]
end

local stylua = {}

stylua.format = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local filepath = Path:new(vim.api.nvim_buf_get_name(bufnr)):absolute()
  local stylua_toml = stylua_finder(filepath)

  if not stylua_toml then
    return
  end

  -- stylua: ignore
  local j = Job:new {
    "stylua",
    "--config-path", stylua_toml,
    "-",
    writer = vim.api.nvim_buf_get_lines(0, 0, -1, false),
  }

  local output = j:sync()

  if j.code ~= 0 then
    -- Schedule this so that it doesn't do dumb stuff like printing two things.
    vim.schedule(function()
      print "[stylua] Failed to process due to errors"
    end)

    return
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)
  vim.api.nvim_buf_clear_namespace(bufnr, Luasnip_ns_id, 0, -1)
  Luasnip_current_nodes[bufnr] = nil
end

return stylua
