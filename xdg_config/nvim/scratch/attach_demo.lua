DETACH = false

local bufnr = 1164

vim.api.nvim_buf_attach(0, false, {
  on_lines = function(_, _, _, first_line, last_line)
    if DETACH then
      return true
    end

    local lines = vim.api.nvim_buf_get_lines(0, first_line, last_line, false)

    vim.schedule(function()
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    end)
  end,
})
