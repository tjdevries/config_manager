local dap = require('dap')

-- dap.adapters.cpp = {
--   type = 'executable',
--   attach = {
--     pidProperty = "pid",
--     pidSelect = "ask"
--   },
--   command = 'lldb-vscode-11',
--   env = {
--     LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
--   },
--   name = "lldb"
-- }

dap.adapters.c = {
  type = 'executable',
  attach = {
    pidProperty = "pid",
    pidSelect = "ask"
  },
  command = 'lldb-vscode-11',
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
  },
  name = "lldb"
}

dap.configurations.c = {
  {
    name = "Launch binary nvim",
    type = 'c',
    request = 'launch',
    program = './build/bin/nvim',
    args = {
      '--headless',
      '-c', 'echo getcompletion("vim.api.nvim_buf_", "lua")',
      '-c', 'qa!'
    },
    cwd = nil,
    environment = nil,
    externalConsole = true,
    MIMode = 'lldb',
  },
  {
    name = "Attach to nvim",
    type = 'c',
    request = 'attach',
    program = './build/bin/nvim',
    args = {
      '--headless',
      '-c', 'echo getcompletion("vim.api.nvim_buf_", "lua")',
      '-c', 'qa!'
    },
    cwd = nil,
    environment = nil,
    externalConsole = true,
    MIMode = 'lldb',
    -- }
  }
}

require('dap-python').setup('~/.pyenv/versions/debugpy/bin/python')


vim.cmd [[nnoremap <silent> <F5> :lua require'dap'.continue()<CR>]]
vim.cmd [[nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>]]
vim.cmd [[nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>]]

vim.cmd [[nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>]]

--[[
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dl :lua require'dap'.repl.run_last()<CR>
--]]
