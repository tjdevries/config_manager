local naughty = require "naughty"
local spawn = require "awful.spawn"

local GET_VOLUME_CMD = "amixer -D pulse sget Master"
local INC_VOLUME_CMD = "amixer -D pulse sset Master 5%+"
local DEC_VOLUME_CMD = "amixer -D pulse sset Master 5%-"

local bind = function(text, cmd)
  return function()
    spawn.easy_async(cmd, function()
      spawn.easy_async(GET_VOLUME_CMD, function(stdout)
        local volume_level = string.match(stdout, "(%d?%d?%d)%%") -- (\d?\d?\d)\%)

        naughty.notify {
          text = string.format("%s: %s", text, volume_level),
          title = "Volume",
          timeout = 1,
        }
      end)
    end)
  end
end

return {
  inc = bind("Up", INC_VOLUME_CMD),
  dec = bind("Down", DEC_VOLUME_CMD),
}
