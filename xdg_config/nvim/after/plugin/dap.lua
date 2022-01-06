local has_dap, dap = pcall(require, "dap")
if not has_dap then
  return
end

dap.set_log_level "TRACE"

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

--  https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
dap.adapters.go = function(callback, _)
  local stdout = vim.loop.new_pipe(false)
  local handle, pid_or_err
  local port = 38697

  handle, pid_or_err = vim.loop.spawn("dlv", {
    stdio = { nil, stdout },
    args = { "dap", "-l", "127.0.0.1:" .. port },
    detached = true,
  }, function(code)
    stdout:close()
    handle:close()

    print("[delve] Exit Code:", code)
  end)

  assert(handle, "Error running dlv: " .. tostring(pid_or_err))

  stdout:read_start(function(err, chunk)
    assert(not err, err)

    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
        print("[delve]", chunk)
      end)
    end
  end)

  -- Wait for delve to start
  vim.defer_fn(function()
    callback { type = "server", host = "127.0.0.1", port = port }
  end, 100)
end

dap.configurations.go = {
  {
    type = "go",
    name = "Debug (from vscode-go)",
    request = "launch",
    showLog = false,
    program = "${file}",
    dlvToolPath = vim.fn.exepath "dlv", -- Adjust to where delve is installed
  },
  {
    type = "go",
    name = "Debug (No File)",
    request = "launch",
    program = "",
  },
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}",
    showLog = true,
    -- console = "externalTerminal",
    -- dlvToolPath = vim.fn.exepath "dlv",
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
  {
    type = "go",
    name = "Run lsif-go-imports in smol_go",
    request = "launch",
    showLog = true,
    program = "./cmd/lsif-go",
    args = {
      "--project-root=/home/tjdevries/sourcegraph/smol_go/",
      "--repository-root=/home/tjdevries/sourcegraph/smol_go/",
      "--module-root=/home/tjdevries/sourcegraph/smol_go/",
      "--repository-remote=github.com/tjdevries/smol_go",
      "--no-animation",
    },
    dlvToolPath = vim.fn.exepath "dlv",
  },
  {
    type = "go",
    name = "Run lsif-go-imports in sourcegraph",
    request = "launch",
    showLog = true,
    program = "./cmd/lsif-go",
    args = {
      "--project-root=/home/tjdevries/sourcegraph/sourcegraph.git/main",
      "--repository-root=/home/tjdevries/sourcegraph/sourcegraph.git/main",
      "--module-root=/home/tjdevries/sourcegraph/sourcegraph.git/main",
      "--no-animation",
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

dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode-12",
  name = "lldb",
}

local extension_path = vim.fn.expand "~/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

-- dap.adapters.rt_lldb = {
--   type = "executable",
--   command = codelldb_path,
--   name = "rt_lldb",
-- }

dap.adapters.rt_lldb = function(callback, _)
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local port
  local error_message = ""

  local opts = {
    stdio = { nil, stdout, stderr },
    args = { "--liblldb", liblldb_path },
    detached = true,
  }

  handle, pid_or_err = vim.loop.spawn(codelldb_path, opts, function(code)
    stdout:close()
    stderr:close()
    handle:close()
    if code ~= 0 then
      print("codelldb exited with code", code)
      print("error message", error_message)
    end
  end)

  assert(handle, "Error running codelldb: " .. tostring(pid_or_err))

  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      if not port then
        local chunks = {}
        for substring in chunk:gmatch "%S+" do
          table.insert(chunks, substring)
        end
        port = tonumber(chunks[#chunks])
        vim.schedule(function()
          callback {
            type = "server",
            host = "127.0.0.1",
            port = port,
          }
        end)
      else
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end
  end)
  stderr:read_start(function(_, chunk)
    if chunk then
      error_message = error_message .. chunk

      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
end

-- function M.setup_adapter()
-- 	local dap = require("dap")
-- 	dap.adapters.rt_lldb = config.options.dap.adapter
-- end

function StartRustServer(args)
  args = args or {}

  if not pcall(require, "dap") then
    vim.notify "nvim-dap not found."
    return
  end

  if not pcall(require, "plenary.job") then
    vim.notify "plenary not found."
    return
  end

  local Job = require "plenary.job"

  -- local cargo_args = get_cargo_args_from_runnables_args(args)

  vim.notify "Compiling a debug build for debugging. This might take some time..."

  Job
    :new({
      command = "cargo",
      args = { "build", "--message-format=json" },
      cwd = nil,
      on_exit = function(j, code)
        if code and code > 0 then
          vim.notify "An error occured while compiling. Please fix all compilation issues and try again."
        end
        vim.schedule(function()
          for _, value in pairs(j:result()) do
            local json = vim.fn.json_decode(value)
            if type(json) == "table" and json.executable ~= vim.NIL and json.executable ~= nil then
              local dap_config = {
                name = "Rust tools debug",
                type = "rt_lldb",
                request = "launch",
                program = json.executable,
                args = args.executableArgs or { "lsif", "/home/tjdevries/build/rmpv/" },
                cwd = args.workspaceRoot,
                stopOnEntry = false,
                runInTerminal = false,
              }
              dap.run(dap_config)

              break
            end
          end
        end)
      end,
    })
    :start()
end

dap.configurations.rust = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  },
  {
    name = "Launch rust-analyzer lsif",
    type = "lldb",
    request = "launch",
    program = "/home/tjdevries/sourcegraph/rust-analyzer.git/monikers-1/target/debug/rust-analyzer",
    args = { "lsif", "/home/tjdevries/build/rmpv/" },
    cwd = "/home/tjdevries/sourcegraph/rust-analyzer.git/monikers-1/",
    stopOnEntry = false,
    runInTerminal = false,
  },
}

vim.cmd [[nnoremap <silent> <F5> :lua require'dap'.continue()<CR>]]
vim.cmd [[nnoremap <silent> <F1> :lua require'dap'.step_into()<CR>]]
vim.cmd [[nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>]]

vim.cmd [[nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>]]
vim.cmd [[nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]]
vim.cmd [[nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>]]

vim.cmd [[nnoremap <silent> <space>dh :lua require('dap.ui.variables').hover()<CR>]]

vim.cmd [[
augroup DapRepl
  au!
  au FileType dap-repl lua require('dap.ext.autocompl').attach()
augroup END
]]

local dap_ui = require "dapui"

local _ = dap_ui.setup {
  -- You can change the order of elements in the sidebar
  sidebar = {
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.75, -- Can be float or integer > 1
      },
      { id = "watches", size = 00.25 },
    },
    size = 50,
    position = "left", -- Can be "left" or "right"
  },

  tray = {
    elements = { "repl" },
    size = 15,
    position = "bottom", -- Can be "bottom" or "top"
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dap_ui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dap_ui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dap_ui.close()
end

--[[
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dl :lua require'dap'.repl.run_last()<CR>
--]]

-- vim.cmd [[nmap <silent> <space>db <Plug>VimspectorToggleBreakpoint]]
-- vim.cmd [[nmap <space>ds <Plug>VimscectorContinue]]
