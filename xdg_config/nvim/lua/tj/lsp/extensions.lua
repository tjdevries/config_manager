local inlay_hints = require('lsp_extensions.inlay_hints')

local M = {}

M.show_line_hints = function()
  vim.lsp.buf_request(0, 'rust-analyzer/inlayHints', inlay_hints.get_params(), inlay_hints.get_callback {
    only_current_line = true
  })
end

-- @rockerboo
M.show_line_hints_on_cursor_events = function()
  vim.cmd [[augroup ShowLineHints]]
  vim.cmd [[  au!]]
  vim.cmd [[  autocmd CursorHold,CursorHoldI,CursorMoved *.rs :lua require('tj.lsp_extensions').show_line_hints()]]
  vim.cmd [[augroup END]]
end

return M

