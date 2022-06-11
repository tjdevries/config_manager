local ok, Job = pcall(require, "plenary.job")
if not ok then
  return
end

local group = vim.api.nvim_create_augroup("scip", { clear = true })
vim.api.nvim_create_autocmd("BufReadCmd", {
  group = group,
  pattern = "*.scip",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local file = vim.fn.expand "<afile>"

    vim.bo[bufnr].modifiable = true
    vim.bo[bufnr].readonly = false

    Job
      :new({
        "protoc",
        "--decode=scip.Index",
        "--proto_path=/home/tjdevries/sourcegraph/scip/",
        "scip.proto",

        writer = Job:new { "cat", file },

        on_stderr = vim.schedule_wrap(function(_, data)
          print("ERR:", data)
        end),

        on_stdout = vim.schedule_wrap(function(_, data)
          vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { data })
        end),

        on_exit = vim.schedule_wrap(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, {})

          vim.bo[bufnr].readonly = true
          vim.bo[bufnr].buftype = "nofile"
          vim.bo[bufnr].modified = false
          vim.bo[bufnr].modifiable = false
          vim.opt_local.wrap = false
        end),
      })
      :start()
  end,
})
