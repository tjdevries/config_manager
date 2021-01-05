local vim = vim

local M = {}

M._original_functions = {}

function M.override(callback, new_function)
  if M._original_functions[callback] == nil then
    M._original_functions[callback] = vim.lsp.callbacks[callback]
  end

  vim.lsp.callbacks[callback] = new_function
end

function M.get_original_function(callback)
  if M._original_functions[callback] == nil then
    M._original_functions[callback] = vim.lsp.callbacks[callback]
  end

  return M._original_functions[callback]
end

return M
