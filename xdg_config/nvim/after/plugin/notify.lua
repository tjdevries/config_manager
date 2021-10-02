-- Automatically opening the UI is deprecated.
-- You can replicate previous behaviour by adding the following to your config

-- local dap, dapui = require('dap'), require('dapui')
-- dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
-- dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
-- dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

-- To hide this message, remove the `open_on_start` settings from your config

local log = require("plenary.log").new {
  plugin = "notify",
  level = "debug",
  use_console = false,
}

vim.notify = function(msg, level, opts)
  log.info(msg, level, opts)

  require "notify"(msg, level, opts)
end
