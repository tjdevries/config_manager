--[[

     Licensed under GNU General Public License v2
      * (c) 2013,      Luca CPZ
      * (c) 2010-2012, Peter Hofmann

--]]

local helpers     = require("lain.helpers")
local wibox       = require("wibox")
local open, match = io.open, string.match

-- System load
-- lain.widget.sysload

local function factory(args)
    args           = args or {}

    local sysload  = { widget = args.widget or wibox.widget.textbox() }
    local timeout  = args.timeout or 2
    local settings = args.settings or function() end

    function sysload.update()
        local f = open("/proc/loadavg")
        local ret = f:read("*all")
        f:close()

        load_1, load_5, load_15 = match(ret, "([^%s]+) ([^%s]+) ([^%s]+)")

        widget = sysload.widget
        settings()
    end

    helpers.newtimer("sysload", timeout, sysload.update)

    return sysload
end

return factory
