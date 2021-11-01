--[[

     Licensed under GNU General Public License v2
      * (c) 2013, Luca CPZ
      * (c) 2010, Adrian C. <anrxc@sysphere.org>

--]]

local helpers = require("lain.helpers")
local shell   = require("awful.util").shell
local wibox   = require("wibox")
local string  = string

-- ALSA volume
-- lain.widget.alsa

local function factory(args)
    args           = args or {}
    local alsa     = { widget = args.widget or wibox.widget.textbox() }
    local timeout  = args.timeout or 5
    local settings = args.settings or function() end

    alsa.cmd           = args.cmd or "amixer"
    alsa.channel       = args.channel or "Master"
    alsa.togglechannel = args.togglechannel

    local format_cmd = string.format("%s get %s", alsa.cmd, alsa.channel)

    if alsa.togglechannel then
        format_cmd = { shell, "-c", string.format("%s get %s; %s get %s",
        alsa.cmd, alsa.channel, alsa.cmd, alsa.togglechannel) }
    end

    alsa.last = {}

    function alsa.update()
        helpers.async(format_cmd, function(mixer)
            local l,s = string.match(mixer, "([%d]+)%%.*%[([%l]*)")
            if alsa.last.level ~= l or alsa.last.status ~= s then
                volume_now = { level = tonumber(l), status = s }
                widget = alsa.widget
                settings()
                alsa.last = volume_now
            end
        end)
    end

    helpers.newtimer(string.format("alsa-%s-%s", alsa.cmd, alsa.channel), timeout, alsa.update)

    return alsa
end

return factory
