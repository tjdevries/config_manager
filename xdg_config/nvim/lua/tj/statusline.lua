vim.cmd [[packadd express_line.nvim]]

pcall(RELOAD, 'el')

local builtin = require('el.builtin')
local extensions = require('el.extensions')
local sections = require('el.sections')
local subscribe = require('el.subscribe')

local lsp_statusline = require('el.plugins.lsp_status')


require('el').setup {
  generator = function(win_id)
    return {
      extensions.mode,
      sections.split,
      subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, bufnr)
        local icon = extensions.file_icon(_, bufnr)
        if icon then
          return icon .. ' '
        end

        return ''
      end),
      builtin.responsive_file(130),
      sections.collapse_builtin {
        ' ',
        builtin.modified_flag
      },
      sections.split,
      lsp_statusline.current_function,
      lsp_statusline.server_progress,
      subscribe.buf_autocmd(
        "el_git_status",
        "BufWritePost",
        function(window, buffer)
          return extensions.git_changes(window, buffer)
        end
      ),
      '[', builtin.line, ' : ',  builtin.column, ']',
      sections.collapse_builtin{
        '[',
        builtin.help_list,
        builtin.readonly_list,
        ']',
      },
      builtin.filetype,
    }
  end
}
