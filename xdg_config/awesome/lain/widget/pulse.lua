--[[

     Licensed under GNU General Public License v2
      * (c) 2016, Luca CPZ

--]]

local helpers = require("lain.helpers")
local shell   = require("awful.util").shell
local wibox   = require("wibox")
local string  = string
local type    = type

-- PulseAudio volume
-- lain.widget.pulse

local function factory(args)
    args           = args or {}

    local pulse    = { widget = args.widget or wibox.widget.textbox(), device = "N/A" }
    local timeout  = args.timeout or 5
    local settings = args.settings or function() end

    pulse.devicetype = args.devicetype or "sink"
    pulse.cmd = args.cmd or "pacmd list-" .. pulse.devicetype .. "s | sed -n -e '/*/,$!d' -e '/index/p' -e '/base volume/d' -e '/volume:/p' -e '/muted:/p' -e '/device\\.string/p'"

    function pulse.update()
        helpers.async({ shell, "-c", type(pulse.cmd) == "string" and pulse.cmd or pulse.cmd() },
        function(s)
            volume_now = {
                index  = string.match(s, "index: (%S+)") or "N/A",
                device = string.match(s, "device.string = \"(%S+)\"") or "N/A",
                muted  = string.match(s, "muted: (%S+)") or "N/A"
            }

            pulse.device = volume_now.index

            local ch = 1
            volume_now.channel = {}
            for v in string.gmatch(s, ":.-(%d+)%%") do
                volume_now.channel[ch] = v
                ch = ch + 1
            end

            volume_now.left  = volume_now.channel[1] or "N/A"
            volume_now.right = volume_now.channel[2] or "N/A"

            widget = pulse.widget
            settings()
        end)
    end

    helpers.newtimer("pulse", timeout, pulse.update)

    return pulse
end

return factory
