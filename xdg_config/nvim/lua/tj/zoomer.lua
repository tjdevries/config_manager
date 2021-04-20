local Job = require('plenary.job')

STOP_TIMERS = false

local period = 300

local start_zoomer = function(start, zoom)
  local timer = vim.loop.new_timer()
  timer:start(start, period, vim.schedule_wrap(function()
    if STOP_TIMERS then
      timer:stop()
      timer:close()

      Job:new {
        "v4l2-ctl", "--set-ctrl", "zoom_absolute=100"
      }:start()
      return
    end

    print("starting: ", zoom)
    Job:new {
      "v4l2-ctl", "--set-ctrl", "zoom_absolute=" .. tostring(zoom)
    }:start()
  end))
end

start_zoomer(0, 100)
start_zoomer(period / 3, 150)
start_zoomer(2 * period / 3, 200)
