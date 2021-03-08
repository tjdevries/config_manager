local dap = require('dap')

-- TODO: How does terminal work?
dap.defaults.fallback.external_terminal = {
  command = '/home/tjdevries/.local/bin/kitty',
  args = {'-e'};
}

vim.g.dap_virtual_text = true

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

-- TODO: Try out the dlv command directly:
--  https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
local use_delve = false
if use_delve then
  dap.adapters.go = function(callback, config)
    -- local handle, pid_or_err, port = nil, nil, 12346

    -- handle, pid_or_err = vim.loop.spawn(
    --   "dlv", {
    --     args = {"dap", "-l", "127.0.0.1:" .. port},
    --     detached = true,
    --   }, vim.schedule_wrap(function(code)
    --     handle:close()
    --     print("Delve has exited with: " .. code)
    --   end)
    -- )

    -- if not handle then
    --   error("FAILED:", pid_or_err)
    -- end

    -- vim.wait(100)

    local port = 38697
    callback { type = "server", host = "127.0.0.1", port = port }
  end
else
  dap.adapters.go = {
    type = 'executable',
    command = '/home/tjdevries/.nvm/versions/node/v14.16.0/bin/node',
    args = { vim.fn.expand("~/build/vscode-go/dist/debugAdapter.js") },
    console = "externalTerminal",
  }
end

dap.configurations.go = {
  {
    type = 'go',
    name = 'Debug',
    request = 'launch',
    showLog = true,
    program = "${file}",
    -- console = "externalTerminal",
    dlvToolPath = vim.fn.exepath('dlv'),
  },
  {
    name = 'Test Current File',
    type = 'go',
    request = 'launch',
    showLog = true,
    mode = "test",
    program = ".",
    dlvToolPath = vim.fn.exepath('dlv'),
  },
  {
    type = 'go',
    name = 'Run lsif-clang indexer',
    request = 'launch',
    showLog = true,
    program = '${file}',
    args = { '--indexer', 'lsif-clang', '--dir', vim.fn.expand('~/sourcegraph/lsif-clang/functionaltest'), },
    dlvToolPath = vim.fn.exepath('dlv'),
  },
}

require('dap-python').setup('~/.pyenv/versions/debugpy/bin/python')


vim.cmd [[nnoremap <silent> <F5> :lua require'dap'.continue()<CR>]]
vim.cmd [[nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>]]

vim.cmd [[nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>]]
vim.cmd [[nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>]]


vim.cmd [[nnoremap <silent> <space>dh :lua require('dap.ui.variables').hover()<CR>]]

--[[
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dl :lua require'dap'.repl.run_last()<CR>
--]]
