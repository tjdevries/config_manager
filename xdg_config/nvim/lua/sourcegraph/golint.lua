local lspconfig_util = require "lspconfig.util"
local Job = require "plenary.job"

local M = {}

local find_root = lspconfig_util.root_pattern ".git"
local golang_lint_bin = "./.bin/golangci-lint-1.37.1-linux-amd64"

M.run = function()
  local root = find_root(vim.fn.expand "%:p")
  if not root then
    return
  end

  --stylua: ignore
  local j = Job:new {
    golang_lint_bin,
    "run",
    "-c", ".golangci.yml",
    "--out-format", "json",

    cwd = root,

    on_exit = vim.schedule_wrap(function(self)
      local output = self:result()
      local issues = vim.fn.json_decode(output).Issues

      if not issues or vim.tbl_isempty(issues) then
        print("[golangci lint] No Issues")
        return
      end

      --[[
        Each entry looks like:

          Pos = {
            Column = 6,
            Filename = "enterprise/cmd/worker/internal/codeintel/indexing/index_scheduler.go",
            Line = 20,
            Offset = 561
          },
          Text = "func `unusedFunc` is unused"

        With some keys we don't care about (yet):

          ExpectNoLint = false, ExpectedNoLintLinter = "", FromLinter = "unused",
          LineRange = { From = 20, To = 0 },
          Replacement = vim.NIL, Severity = "", SourceLines = vim.NIL,
      --]]

      local results = {}
      for _, issue in ipairs(issues) do
        table.insert(results, {
          filename = issue.Pos.Filename,
          lnum = issue.Pos.Line,
          text = issue.Text,
        })
      end

      vim.fn.setqflist(results)
      vim.cmd [[copen]]
    end),
  }

  j:start()

  return root
end

return M
