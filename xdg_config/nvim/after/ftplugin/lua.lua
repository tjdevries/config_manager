local ok, documentation = pcall(require, "sg.cody.experimental.documentation")
if not ok then
  return
end

vim.api.nvim_buf_create_user_command(0, "CodyDocumentFunction", function(command)
  local bufnr = vim.api.nvim_get_current_buf()
  local start_line = command.line1 - 1
  documentation.function_documentation(bufnr, start_line, command.line2)
end, { range = 2 })
