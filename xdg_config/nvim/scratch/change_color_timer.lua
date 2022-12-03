local Group = require("colorbuddy.group").Group
local c = require("colorbuddy.color").colors
local g = require("colorbuddy.group").groups

local timer = vim.loop.new_timer()

local count = 0

Group.new("Normal", c.superwhite, c.gray0)
timer:start(
  100,
  100,
  vim.schedule_wrap(function()
    if count > 10 then
      timer:close()
      timer:stop()
      return
    end

    count = count + 1

    Group.new("Normal", c.superwhite, g.normal.bg:dark(0.01))
  end)
)
