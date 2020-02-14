local vim = vim
local api = vim.api

local F = require("custom.functional")


local split = vim.split
local function split_lines(value)
  if type(value) == type({}) then
    return value
  end

  return split(value, '\n', true)
end

local function get_default_bufnr_and_namespace(bufnr, namespace)
  if bufnr == nil then
    bufnr = api.nvim_buf_get_number(0)
  end

  if namespace == nil then
    namespace = -1
  end

  return bufnr, namespace
end
local M = {}

M._current_scratch = {}

-- Example: create a float with scratch buffer: >

--     let buf = nvim_create_buf(v:false, v:true)
--     call nvim_buf_set_lines(buf, 0, -1, v:true, ["test", "text"])
--     let opts = {'relative': 'cursor', 'width': 10, 'height': 2, 'col': 0,
--         \ 'row': 1, 'anchor': 'NW', 'style': 'minimal'}
--     let win = nvim_open_win(buf, 0, opts)
--     " optional: change highlight, otherwise Pmenu is used
--     call nvim_win_set_option(win, 'winhl', 'Normal:MyHighlight')

-- @param text str
-- @param bufnr number
-- @param namespace number
function M.create_floating_scratch(text, floating_options, bufnr, namespace)
  bufnr, namespace = get_default_bufnr_and_namespace(bufnr, namespace)

  M.close_floating_scratch(bufnr, namespace)

  local buf = api.nvim_create_buf(false, true)

  api.nvim_buf_set_lines(buf, 0, -1, true, split_lines(text))

  local window_width = api.nvim_win_get_width(0)
  local window_height = api.nvim_win_get_height(0)

  local window_percentage = 0.2
  if window_width > 140 then
    window_percentage = 0.4
  end

  local floating_width = math.floor(window_width * window_percentage)
  local floating_height = window_height - 2

  -- TODO: Determine the opts that make this nice and easy.
  local opts = {
    relative="win",
    width=floating_width,
    height=floating_height,
    anchor="NW",
    style="minimal",
    -- definitely needs work
    col=window_width - floating_width - 1,
    row=1,  -- One row below the top row
  }

  local win = api.nvim_open_win(buf, false, opts)

  api.nvim_win_set_option(win, 'winhl', 'Normal:MyHighlight')
  api.nvim_win_set_option(win, 'wrap', false)

  M.set_floating_scratch(bufnr, namespace, win)

  if floating_options.border then
    local border_win = M.create_window_border(opts)
    M.set_floating_scratch(bufnr, namespace, border_win)
  end

  if not floating_options.no_scroll then
    api.nvim_win_set_option(0, 'scrollbind', true)
    api.nvim_win_set_option(win, 'scrollbind', true)
  end

  return win
end

function M.close_floating_scratch(bufnr, namespace)
  bufnr, namespace = get_default_bufnr_and_namespace(bufnr, namespace)

  if M._current_scratch[bufnr] then
    if M._current_scratch[bufnr][namespace] then
      for _, winnr in ipairs(M._current_scratch[bufnr][namespace]) do
        api.nvim_win_close(winnr, false)
      end
    end
  end

  if M._current_scratch[bufnr] == nil then
    M._current_scratch[bufnr] = {}
  end

  M._current_scratch[bufnr][namespace] = {}
end

function M.set_floating_scratch(bufnr, namespace, floating_win)
  if M._current_scratch[bufnr] == nil then
    M._current_scratch[bufnr] = {}
  end

  if M._current_scratch[bufnr][namespace] == nil then
    M._current_scratch[bufnr][namespace] = {}
  end

  table.insert(M._current_scratch[bufnr][namespace], floating_win)
end


function M.create_window_border(original_window_options)
  local win_height = original_window_options.height
  local win_width = original_window_options.width
  local row = original_window_options.row
  local col = original_window_options.col
  local relative = original_window_options.relative

  local border_buf = vim.api.nvim_create_buf(false, true)

  local border_lines = { '╔' .. string.rep('═', win_width) .. '╗' }
  local middle_line = '║' .. string.rep(' ', win_width) .. '║'

  for _=1, win_height do
    table.insert(border_lines, middle_line)
  end

  table.insert(border_lines, '╚' .. string.rep('═', win_width) .. '╝')

  local border_opts = {
    style = "minimal",
    relative = relative,
    width = win_width + 2,
    height = win_height + 2,
    row = row - 1,
    col = col - 1
  }

  vim.api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

  local border_win = vim.api.nvim_open_win(border_buf, false, border_opts)

  return border_win
end

return M
