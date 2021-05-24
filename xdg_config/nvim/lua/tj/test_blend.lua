local ui = vim.api.nvim_list_uis()[1]

local bufnr = vim.api.nvim_create_buf(false, true)
local win = vim.api.nvim_open_win(bufnr, true, {
  relative = "editor",
  width = ui.width,
  height = ui.height,
  row = 10,
  col = 10,
  style = "minimal",
})

vim.api.nvim_win_set_option(win, "winblend", 1)

local blend_start = 15
local offset = 1

CANCEL = false
local timer = vim.loop.new_timer()
timer:start(0, 50, vim.schedule_wrap(function()
  blend_start = blend_start + offset

  if blend_start > 90 then
    offset = -1
  elseif blend_start < 10 then
    offset = 1
  end

  if CANCEL or not vim.api.nvim_win_is_valid(win) then
    timer:close()
    timer:stop()
    return
  end

  vim.cmd([[highlight NormalFloat blend=]] .. tostring(blend_start))
end))
