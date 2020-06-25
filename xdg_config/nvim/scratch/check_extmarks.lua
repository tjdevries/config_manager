
-- RESULT: Proves you can get extmarks without checking the highlights.

local client_id = 4
local namespace = vim.api.nvim_create_namespace(string.format('vim_lsp_diagnostics:%s', client_id))
local other_namespace = vim.api.nvim_create_namespace('vim_lsp_diagnostics')

local unused_var = 7

local extmarks = vim.api.nvim_buf_get_extmarks(0, namespace, 0, -1, {})
print(vim.inspect(extmarks))

local other_extmarks = vim.api.nvim_buf_get_extmarks(0, other_namespace, 0, -1, {})
print(vim.inspect(other_extmarks))
