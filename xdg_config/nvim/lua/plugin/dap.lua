local dap = require "dap"

-- TODO: How does terminal work?
dap.defaults.fallback.external_terminal = {
  command = "/home/tjdevries/.local/bin/kitty",
  args = { "-e" },
}

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
    host = function()
      return "127.0.0.1"
    end,
    port = function()
      -- local val = tonumber(vim.fn.input('Port: '))
      -- assert(val, "Please provide a port number")
      local val = 54231
      return val
    end,
  },
}

dap.adapters.nlua = function(callback, config)
  callback { type = "server", host = config.host, port = config.port }
end

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
  name = "lldb",

  type = "executable",
  attach = {
    pidProperty = "pid",
    pidSelect = "ask",
  },
  command = "lldb-vscode-11",
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
  },
}

dap.configurations.c = {
  {
    name = "Launch binary nvim",
    type = "c",
    request = "launch",
    program = "./build/bin/nvim",
    args = {
      "--headless",
      "-c",
      'echo getcompletion("vim.api.nvim_buf_", "lua")',
      "-c",
      "qa!",
    },
    cwd = nil,
    environment = nil,
    externalConsole = true,
    MIMode = "lldb",
  },
  {
    name = "Deprecated",
    type = "c",
    request = "attach",
    program = "./build/bin/nvim",
    cwd = vim.fn.expand "~/build/neovim/",
    -- environment = nil,
    externalConsole = false,
    MIMode = "gdb",
  },
  {
    name = "Attach to Neovim",
    type = "c",
    request = "attach",
    program = vim.fn.expand "~/build/neovim/build/bin/nvim",
    cwd = vim.fn.getcwd(),
    externalConsole = true,
    MIMode = "gdb",
  },
  {
    -- If you get an "Operation not permitted" error using this, try disabling YAMA:
    --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Careful, don't try to attach to the neovim instance that runs *this*
    name = "Fancy attach",
    type = "c",
    request = "attach",
    pid = function()
      local output = vim.fn.system { "ps", "a" }
      local lines = vim.split(output, "\n")
      local procs = {}
      for _, line in pairs(lines) do
        -- output format
        --    " 107021 pts/4    Ss     0:00 /bin/zsh <args>"
        local parts = vim.fn.split(vim.fn.trim(line), " \\+")
        local pid = parts[1]
        local name = table.concat({ unpack(parts, 5) }, " ")
        if pid and pid ~= "PID" then
          pid = tonumber(pid)
          if pid ~= vim.fn.getpid() then
            table.insert(procs, { pid = pid, name = name })
          end
        end
      end
      local choices = { "Select process" }
      for i, proc in ipairs(procs) do
        table.insert(choices, string.format("%d: pid=%d name=%s", i, proc.pid, proc.name))
      end
      -- Would be cool to have a fancier selection, but needs to be sync :/
      -- Should nvim-dap handle coroutine results?
      local choice = vim.fn.inputlist(choices)
      if choice < 1 or choice > #procs then
        return nil
      end
      return procs[choice].pid
    end,
    args = {},
  },
  -- {
  --   name = "Run functional tests",
  --   type = 'c',
  --   request = 'attach',
  --   program = 'make',
  --   args = { 'functionaltest', },
  --   cwd = nil,
  --   environment = {
  --     TEST_FILE = "./test/functional/autocmd/fast/",
  --   },
  --   externalConsole = true,
  --   MIMode = 'lldb',
  -- },
  --[[
  {
    "type": "gdb",
    "request": "attach",
    "name": "Attach to gdbserver",
    "executable": "<path to the elf/exe file relativ to workspace root in order to load the symbols>",
    "target": "X.X.X.X:9999",
    "remote": true,
    "cwd": "${workspaceRoot}", 
    "gdbpath": "path/to/your/gdb",
    "autorun": [
            "any gdb commands to initiate your environment, if it is needed"
        ]
}
  --]]
  {
    type = "c",
    request = "attach",
    program = "./build/bin/nvim",
    name = "Attach to gdbserver::Neovim",
    target = "localhost:7777",
    remote = true,
    cwd = vim.fn.expand "~/build/neovim",
    gdbpath = vim.fn.exepath "gdb",
  },
}

-- TODO: Try out the dlv command directly:
--  https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
local use_delve = true
if use_delve then
  dap.adapters.go = function(callback, config)
    local handle, pid_or_err, port = nil, nil, 12346

    handle, pid_or_err = vim.loop.spawn("dlv", {
      args = { "dap", "-l", "127.0.0.1:" .. port },
      detached = true,
      cwd = vim.loop.cwd(),
    }, vim.schedule_wrap(
      function(code)
        handle:close()
        print("Delve has exited with: " .. code)
      end
    ))

    if not handle then
      error("FAILED:", pid_or_err)
    end

    vim.defer_fn(function()
      callback { type = "server", host = "127.0.0.1", port = port }
    end, 100)
  end
else
  dap.adapters.go = {
    type = "executable",
    command = "/home/tjdevries/.nvm/versions/node/v14.16.0/bin/node",
    args = { vim.fn.expand "~/build/vscode-go/dist/debugAdapter.js" },
    console = "externalTerminal",
  }
end

dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    showLog = true,
    program = "${file}",
    -- console = "externalTerminal",
    dlvToolPath = vim.fn.exepath "dlv",
  },
  {
    name = "Test Current File",
    type = "go",
    request = "launch",
    showLog = true,
    mode = "test",
    program = ".",
    dlvToolPath = vim.fn.exepath "dlv",
  },
  {
    type = "go",
    name = "Run lsif-clang indexer",
    request = "launch",
    showLog = true,
    program = ".",
    args = {
      "--indexer",
      "lsif-clang compile_commands.json",
      "--dir",
      vim.fn.expand "~/sourcegraph/lsif-clang/functionaltest",
      "--debug",
    },
    dlvToolPath = vim.fn.exepath "dlv",
  },
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Build api",
    program = "${file}",
    args = { "--target", "api" },
    console = "integratedTerminal",
  },
  {
    type = "python",
    request = "launch",
    name = "lsif",
    program = "src/lsif/__main__.py",
    args = {},
    console = "integratedTerminal",
  },
}

require("dap-python").setup("python", {
  include_configs = true,
})

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

-- vim.cmd [[nmap <silent> <space>db <Plug>VimspectorToggleBreakpoint]]
-- vim.cmd [[nmap <space>ds <Plug>VimscectorContinue]]
