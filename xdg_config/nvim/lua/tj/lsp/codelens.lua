local M = {}

M.run = function()
  if vim.o.modified then
    vim.cmd [[w]]
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_win_get_cursor(0)[1]

  local lenses = vim.deepcopy(vim.lsp.codelens.get(bufnr))

  lenses = vim.tbl_filter(function(v)
    return v.range.start.line < line
  end, lenses)

  table.sort(lenses, function(a, b)
    return a.range.start.line < b.range.start.line
  end)

  local _, lens = next(lenses)

  local client_id = next(vim.lsp.buf_get_clients(bufnr))
  local client = vim.lsp.get_client_by_id(client_id)
  client.request("workspace/executeCommand", lens.command, function(...)
    local result = vim.lsp.handlers["workspace/executeCommand"](...)
    vim.lsp.codelens.refresh()
    return result
  end, bufnr)
end

return M
