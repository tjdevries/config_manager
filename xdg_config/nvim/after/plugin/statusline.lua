-- TODO: Need to add those sweet sweet lsp workspace diagnostic counts
if not pcall(require, "el") then
  -- TODO: Add in a nice default statusline here.
  -- Would be good to research anyway for the course
  return
end

RELOAD "el"
require("el").reset_windows()

vim.opt.laststatus = 3

if false then
  -- Disappearing statusline for commands
  vim.opt.cmdheight = 0
  vim.api.nvim_create_autocmd("ModeChanged", {
    group = vim.api.nvim_create_augroup("StatusDisappear", { clear = true }),
    callback = function()
      if vim.v.event.new_mode == "c" then
        vim.opt.laststatus = 0
      elseif vim.v.event.old_mode == "c" then
        vim.opt.laststatus = 3
      end

      pcall(vim.cmd, [[silent! redraw]])
    end,
  })
end

local builtin = require "el.builtin"
local extensions = require "el.extensions"
local sections = require "el.sections"
local subscribe = require "el.subscribe"
local lsp_statusline = require "el.plugins.lsp_status"
local helper = require "el.helper"
local diagnostic = require "el.diagnostic"

local has_lsp_extensions, ws_diagnostics = pcall(require, "lsp_extensions.workspace.diagnostic")

-- TODO: Spinning planet extension. Integrated w/ telescope.
-- ◐ ◓ ◑ ◒
-- 🌛︎🌝︎🌜︎🌚︎
-- Show telescope icon / emoji when you open it as well

local git_icon = subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, bufnr)
  local icon = extensions.file_icon(_, bufnr)
  if icon then
    return icon .. " "
  end

  return ""
end)

local git_branch = subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
  local branch = extensions.git_branch(window, buffer)
  if branch then
    return " " .. extensions.git_icon() .. " " .. branch
  end
end)

local git_changes = subscribe.buf_autocmd("el_git_changes", "BufWritePost", function(window, buffer)
  return extensions.git_changes(window, buffer)
end)

local ws_diagnostic_counts = function(_, buffer)
  if not has_lsp_extensions then
    return ""
  end

  local messages = {}

  local error_count = ws_diagnostics.get_count(buffer.bufnr, "Error")

  local x = "⬤"
  if error_count == 0 then
    -- pass
  elseif error_count < 5 then
    table.insert(messages, string.format("%s#%s#%s%%*", "%", "StatuslineError" .. error_count, x))
  else
    table.insert(messages, string.format("%s#%s#%s%%*", "%", "StatuslineError5", x))
  end

  return table.concat(messages, "")
end

local show_current_func = function(window, buffer)
  if buffer.filetype == "lua" then
    return ""
  end

  return lsp_statusline.current_function(window, buffer)
end

local minimal_status_line = function(_, buffer)
  if string.find(buffer.name, "sourcegraph/sourcegraph") then
    return true
  end
end

local is_sourcegraph = function(_, buffer)
  if string.find(buffer.name, "sg://") then
    return true
  end
end

local diagnostic_display = diagnostic.make_buffer()

require("el").setup {
  generator = function(window, buffer)
    local is_minimal = minimal_status_line(window, buffer)
    local is_sourcegraph = is_sourcegraph(window, buffer)

    local mode = extensions.gen_mode { format_string = " %s " }
    if is_sourcegraph then
      return {
        { mode },
        { sections.split, required = true },
        { builtin.file },
        { sections.split, required = true },
        { builtin.filetype },
      }
    end

    local items = {
      { mode, required = true },
      { git_branch },
      { " " },
      { sections.split, required = true },
      { git_icon },
      { sections.maximum_width(builtin.file_relative, 0.60), required = true },
      { sections.collapse_builtin { { " " }, { builtin.modified_flag } } },
      { sections.split, required = true },
      { diagnostic_display },
      { show_current_func },
      -- { lsp_statusline.server_progress },
      -- { ws_diagnostic_counts },
      { git_changes },
      { "[" },
      { builtin.line_with_width(3) },
      { ":" },
      { builtin.column_with_width(2) },
      { "]" },
      {
        sections.collapse_builtin {
          "[",
          builtin.help_list,
          builtin.readonly_list,
          "]",
        },
      },
      { builtin.filetype },
    }

    local add_item = function(result, item)
      if is_minimal and not item.required then
        return
      end

      table.insert(result, item)
    end

    local result = {}
    for _, item in ipairs(items) do
      add_item(result, item)
    end

    return result
  end,
}

require("fidget").setup {}

--[[
let s:left_sep = ' ❯❯ '
let s:right_sep = ' ❮❮ '

        let s:seperator.filenameright = ''
        let s:seperator.filesizeright = ''
        let s:seperator.gitleft = ''
        let s:seperator.gitright = ''
        let s:seperator.lineinfoleft = ''
        let s:seperator.lineformatright = ''
        let s:seperator.EndSeperate = ' '
        let s:seperator.emptySeperate1 = ''
    elseif a:style == 'slant-cons'
        let s:seperator.homemoderight = ''
        let s:seperator.filenameright = ''
        let s:seperator.filesizeright = '' let s:seperator.gitleft = ''
        let s:seperator.gitright = ''
        let s:seperator.lineinfoleft = ''
        let s:seperator.lineformatright = ''
        let s:seperator.EndSeperate = ' '
        let s:seperator.emptySeperate1 = ''
    elseif a:style == 'slant-fade'
        let s:seperator.homemoderight = ''
        let s:seperator.filenameright = ''
        let s:seperator.filesizeright = ''
        let s:seperator.gitleft = ''
        let s:seperator.gitright = ''
        " let s:seperator.gitright = ''
        let s:seperator.lineinfoleft = ''
        let s:seperator.lineformatright = ''
        let s:seperator.EndSeperate = ' '
        let s:seperator.emptySeperate1 = ''
--]]
