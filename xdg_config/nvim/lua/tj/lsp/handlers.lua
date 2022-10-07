-- Jump directly to the first available definition every time.
vim.lsp.handlers["textDocument/definition"] = function(_, result)
  if not result or vim.tbl_isempty(result) then
    print "[LSP] Could not find definition"
    return
  end

  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1], "utf-8")
  else
    vim.lsp.util.jump_to_location(result, "utf-8")
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.handlers["textDocument/publishDiagnostics"], {
    signs = {
      severity_limit = "Error",
    },
    underline = {
      severity_limit = "Warning",
    },
    virtual_text = true,
  })

vim.lsp.handlers["window/showMessage"] = require "tj.lsp.show_message"

local M = {}

M.implementation = function()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, "textDocument/implementation", params, function(err, result, ctx, config)
    local bufnr = ctx.bufnr
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")

    -- In go code, I do not like to see any mocks for impls
    if ft == "go" then
      local new_result = vim.tbl_filter(function(v)
        return not string.find(v.uri, "mock_")
      end, result)

      if #new_result > 0 then
        result = new_result
      end
    end

    vim.lsp.handlers["textDocument/implementation"](err, result, ctx, config)
    vim.cmd [[normal! zz]]
  end)
end

vim.lsp.codelens.display = require("gl.codelens").display

--[[
|| brrr brrr brrr.... running test...
|| {
||   arguments = { "file:///home/tjdevries/plugins/green_light.nvim/test/green_light/example_test.go", { "TestExample" }, vim.NIL },
||   command = "gopls.test",
||   title = "run test"
|| }
|| {
||   bufnr = 1,
||   client_id = 1
|| }
--]]
-- vim.lsp.commands["gopls.test"] = function(command, context)
--   local TestRun = require("gl.test").TestRun
--
--   local test_pattern = command.arguments[2][1]
--   print("test pattern:", test_pattern)
--
--   TestRun
--     :new({
--       file_pattern = "/home/tjdevries/plugins/green_light.nvim/test/green_light/...",
--       test_pattern = "^" .. test_pattern .. "$",
--     })
--     :run()
-- end

return M
