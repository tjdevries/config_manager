local vim = vim
local api = vim.api
local util = require('vim.lsp.util')

local floating_text = require("custom.floating_text")

local M = {}

M._use_custom = true
M._should_display = true

function M.set_diagnostic_display(value)
  -- Turn value into a boolean
  value = not not value

  if not value then
    floating_text.close_floating_scratch()
  else
    M.create_floating_diagnostic()
  end

  M._should_display = value
end

function M.use_custom(value)
  -- Toggle if value is nil
  if value == nil then
    M._use_custom = not M._use_custom
    return
  end

  value = not not value
  M._use_custom = value
end

function M.create_floating_diagnostic(buffer_number)
  if not M._should_display then
    floating_text.close_floating_scratch()
    return
  end

  if buffer_number == nil then
    buffer_number = api.nvim_buf_get_number(0)
  end

  local diagnostics = vim.lsp.util.buf_get_saved_diagnostics(buffer_number)

  if diagnostics == nil or diagnostics == {} then
    floating_text.close_floating_scratch()
    return
  end

  local number_of_lines = vim.api.nvim_call_function('line', {'$'})

  local buf_text_array = {}
  for line_number=1,number_of_lines do
    buf_text_array[line_number] = ""

    if diagnostics[line_number] then
      buf_text_array[line_number] = diagnostics[line_number][1].message
    end
  end

  local floating_options = {
    border=true
  }

  floating_text.create_floating_scratch(buf_text_array, floating_options)
end

function M.handle_diagnostics(_1, _2, result)
  if not M._use_custom then
    floating_text.close_floating_scratch()

    if M._should_display then
      require("custom.lsp_override").get_original_function("textDocument/publishDiagnostics")(_1, _2, result)
    end

    return
  end

  if not result then return end
  local uri = result.uri
  local bufnr = vim.uri_to_bufnr(uri)
  if not bufnr then
    err_message("LSP.publishDiagnostics: Couldn't find buffer for ", uri)
    return
  end
  util.buf_clear_diagnostics(bufnr)
  util.buf_diagnostics_save_positions(bufnr, result.diagnostics)
  util.buf_diagnostics_underline(bufnr, result.diagnostics)

  M.create_floating_diagnostic(bufnr)
end


return M
