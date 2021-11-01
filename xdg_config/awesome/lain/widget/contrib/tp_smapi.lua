--[[

     Licensed under GNU General Public License v2
      * (c) 2018, Luca CPZ
      * (c) 2013, Conor Heine

--]]

local helpers = require("lain.helpers")
local focused = require("awful.screen").focused
local naughty = require("naughty")
local wibox   = require("wibox")
local string  = string
local type    = type

-- ThinkPad battery infos and widget creator
-- http://www.thinkwiki.org/wiki/Tp_smapi
-- lain.widget.contrib.tp_smapi

local function factory(apipath)
    local tp_smapi = {
        path = apipath or "/sys/devices/platform/smapi"
    }

    function tp_smapi.get(batid, feature)
        return helpers.first_line(string.format("%s/%s/%s", tp_smapi.path, batid or "BAT0", feature or ""))
    end

    function tp_smapi.installed(batid)
        return tp_smapi.get(batid, "installed") == "1"
    end

    function tp_smapi.status(batid)
        return tp_smapi.get(batid, "state")
    end

    function tp_smapi.percentage(batid)
        return tp_smapi.get(batid, "remaining_percent")
    end

    -- either running or charging time
    function tp_smapi.time(batid)
        local status = tp_smapi.status(batid)
        local mins_left = tp_smapi.get(batid, string.match(string.lower(status), "discharging") and "remaining_running_time" or "remaining_charging_time")
        if not string.find(mins_left, "^%d+") then return "N/A" end
        return string.format("%02d:%02d", math.floor(mins_left / 60), mins_left % 60) -- HH:mm
    end

    function tp_smapi.hide()
        if not tp_smapi.notification then return end
        naughty.destroy(tp_smapi.notification)
        tp_smapi.notification = nil
    end

    function tp_smapi.show(batid, seconds, scr)
        if not tp_smapi.installed(batid) then return end

        local mfgr   = tp_smapi.get(batid, "manufacturer") or "no_mfgr"
        local model  = tp_smapi.get(batid, "model") or "no_model"
        local chem   = tp_smapi.get(batid, "chemistry") or "no_chem"
        local status = tp_smapi.get(batid, "state")
        local time   = tp_smapi.time(batid)
        local msg

        if status and status ~= "idle" then
            msg = string.format("[%s] %s %s", status, time ~= "N/A" and time or "unknown remaining time",
                  string.lower(status):gsub(" ", ""):gsub("\n", "") == "charging" and " until charged" or " remaining")
        else
            msg = "On AC power"
        end

        tp_smapi.hide()
        tp_smapi.notification = naughty.notify {
            title   = string.format("%s: %s %s (%s)", batid, mfgr, model, chem),
            text    = msg,
            timeout = type(seconds) == "number" and seconds or 0,
            screen  = scr or focused()
        }
    end

    function tp_smapi.create_widget(args)
        args            = args or {}

        local pspath    = args.pspath or "/sys/class/power_supply/"
        local batteries = args.batteries or (args.battery and {args.battery}) or {}
        local timeout   = args.timeout or 30
        local settings  = args.settings or function() end

        if #batteries == 0 then
            helpers.line_callback("ls -1 " .. pspath, function(line)
                local bstr = string.match(line, "BAT%w+")
                if bstr then batteries[#batteries + 1] = bstr end
            end)
        end

        local all_batteries_installed = true

        for _, battery in ipairs(batteries) do
            if not tp_smapi.installed(battery) then
                naughty.notify {
                    preset = naughty.config.critical,
                    title  = "tp_smapi: error while creating widget",
                    text   = string.format("battery %s is not installed", battery)
                }
                all_batteries_installed = false
                break
            end
        end

        if not all_batteries_installed then return end

        tpbat = {
            batteries = batteries,
            widget    = args.widget or wibox.widget.textbox()
        }

        function tpbat.update()
            tpbat_now = {
                n_status = {},
                n_perc   = {},
                n_time   = {},
                status   = "N/A"
            }

            for i = 1, #batteries do
                tpbat_now.n_status[i] = tp_smapi.status(batteries[i]) or "N/A"
                tpbat_now.n_perc[i] = tp_smapi.percentage(batteries[i])
                tpbat_now.n_time[i] = tp_smapi.time(batteries[i]) or "N/A"

                if not tpbat_now.n_status[i]:lower():match("full") then
                    tpbat_now.status = tpbat_now.n_status[i]
                end
            end

            widget = tpbat.widget -- backwards compatibility
            settings()
        end

        helpers.newtimer("thinkpad-batteries", timeout, tpbat.update)

        return tpbat
    end

    return tp_smapi
end

return factory
