local ns = vim.api.nvim_create_namespace "vsc*de"

local attached_buffers = {}

vim.api.nvim_create_user_command("VSCensorToggle", function()
  local bufnr = vim.api.nvim_get_current_buf()
  if attached_buffers[bufnr] then
    attached_buffers[bufnr] = nil

    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    vim.diagnostic.set(ns, bufnr, {}, {})

    return
  end

  attached_buffers[bufnr] = true

  vim.api.nvim_buf_attach(bufnr, true, {
    on_lines = function()
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

      if not attached_buffers[bufnr] then
        return true
      end

      local diagnostics = {}
      for idx, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)) do
        local col = 0
        local regex = "[Vv][Ss][%s-]*[Cc][Oo][Dd][Ee]"
        while string.find(line, regex, col, false) do
          local col_start, col_end = string.find(line, regex, col, false)
          vim.api.nvim_buf_set_extmark(bufnr, ns, idx - 1, col_end - 3, {
            virt_text = { { "█", "Error" } },
            virt_text_pos = "overlay",
          })

          table.insert(diagnostics, {
            bufnr = bufnr,
            lnum = idx - 1,
            col = col_start - 1,
            end_col = col_end,
            severity = "Error",
            message = "This is a family friendly stream",
            source = "Actually Open Source Editor",
          })

          col = col_end + 1
        end
      end

      vim.diagnostic.set(ns, bufnr, diagnostics)
    end,
  })
end, {})
