--[[

     Licensed under GNU General Public License v2
      * (c) 2013, Luca CPZ

--]]

local helpers  = require("lain.helpers")
local wibox    = require("wibox")
local tonumber = tonumber

-- {thermal,core} temperature info
-- lain.widget.temp

local function factory(args)
    args           = args or {}

    local temp     = { widget = args.widget or wibox.widget.textbox() }
    local timeout  = args.timeout or 30
    local tempfile = args.tempfile or "/sys/devices/virtual/thermal/thermal_zone0/temp"
    local settings = args.settings or function() end

    function temp.update()
        helpers.async({"find", "/sys/devices", "-type", "f", "-name", "*temp*"}, function(f)
            temp_now = {}
            local temp_fl, temp_value
            for t in f:gmatch("[^\n]+") do
                temp_fl = helpers.first_line(t)
                if temp_fl then
                    temp_value = tonumber(temp_fl)
                    temp_now[t] = temp_value and temp_value/1e3 or temp_fl
                end
            end
            coretemp_now = temp_now[tempfile] or "N/A"
            widget = temp.widget
            settings()
        end)
    end

    helpers.newtimer("thermal", timeout, temp.update)

    return temp
end

return factory
