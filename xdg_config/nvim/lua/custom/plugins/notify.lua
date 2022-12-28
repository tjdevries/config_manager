return {
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      local log = require("plenary.log").new {
        plugin = "notify",
        level = "debug",
        use_console = false,
      }

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.notify = function(msg, level, opts)
        log.info(msg, level, opts)
        if string.find(msg, "method .* is not supported") then
          return
        end

        require "notify"(msg, level, opts)
      end
    end,
    cond = function()
      if not pcall(require, "plenary") then
        return false
      end

      if pcall(require, "noice") then
        return false
      end
      return true
    end,
  },
}
