if not pcall(require, "plenary") then
  return
end

if pcall(require, "noice") then
  return
end

local log = require("plenary.log").new {
  plugin = "notify",
  level = "debug",
  use_console = false,
}

vim.notify = function(msg, level, opts)
  log.info(msg, level, opts)
  if string.find(msg, "method .* is not supported") then
    return
  end

  require "notify"(msg, level, opts)
end
