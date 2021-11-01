--[[

     Licensed under GNU General Public License v2
      * (c) 2018, Uli Schlacter
      * (c) 2018, Otto Modinos
      * (c) 2013, Luca CPZ

--]]

local helpers    = require("lain.helpers")
local Gio        = require("lgi").Gio
local focused    = require("awful.screen").focused
local wibox      = require("wibox")
local naughty    = require("naughty")
local gears      = require("gears")
local math       = math
local string     = string
local tconcat    = table.concat
local type       = type
local query_size = Gio.FILE_ATTRIBUTE_FILESYSTEM_SIZE
local query_free = Gio.FILE_ATTRIBUTE_FILESYSTEM_FREE
local query_used = Gio.FILE_ATTRIBUTE_FILESYSTEM_USED
local query      = query_size .. "," .. query_free .. "," .. query_used

-- File systems info
-- lain.widget.fs

local function factory(args)
    args     = args or {}

    local fs = {
        widget = args.widget or wibox.widget.textbox(),
        units = {
            [1] = "Kb", [2] = "Mb", [3] = "Gb",
            [4] = "Tb", [5] = "Pb", [6] = "Eb",
            [7] = "Zb", [8] = "Yb"
        }
    }

    function fs.hide()
        if not fs.notification then return end
        naughty.destroy(fs.notification)
        fs.notification = nil
    end

    function fs.show(seconds, scr)
        fs.hide()
        fs.update(function()
            fs.notification_preset.screen = fs.followtag and focused() or scr or 1
            fs.notification = naughty.notify {
                preset  = fs.notification_preset,
                timeout = type(seconds) == "number" and seconds or 5
            }
        end)
    end

    local timeout   = args.timeout or 600
    local partition = args.partition
    local threshold = args.threshold or 99
    local showpopup = args.showpopup or "on"
    local settings  = args.settings or function() end

    fs.followtag           = args.followtag or false
    fs.notification_preset = args.notification_preset

    if not fs.notification_preset then
        fs.notification_preset = {
            font = "Monospace 10",
            fg   = "#FFFFFF",
            bg   = "#000000"
        }
    end

    local function update_synced()
        local pathlen = 10
        fs_now = {}

        local notifypaths = {}
        for _, mount in ipairs(Gio.unix_mounts_get()) do
            local path = Gio.unix_mount_get_mount_path(mount)
            local root = Gio.File.new_for_path(path)
            local info = root:query_filesystem_info(query)

            if info then
                local size = info:get_attribute_uint64(query_size)
                local used = info:get_attribute_uint64(query_used)
                local free = info:get_attribute_uint64(query_free)

                if size > 0 then
                    local units = math.floor(math.log(size)/math.log(1024))

                    fs_now[path] = {
                        units      = fs.units[units],
                        percentage = math.floor(100 * used / size), -- used percentage
                        size       = size / math.pow(1024, units),
                        used       = used / math.pow(1024, units),
                        free       = free / math.pow(1024, units)
                    }

                    if fs_now[path].percentage > 0 then -- don't notify unused file systems
                        notifypaths[#notifypaths+1] = path

                        if #path > pathlen then
                            pathlen = #path
                        end
                    end
                end
            end
        end

        widget = fs.widget
        settings()

        if partition and fs_now[partition] and fs_now[partition].percentage >= threshold then
            if not helpers.get_map(partition) then
                naughty.notify {
                    preset = naughty.config.presets.critical,
                    title  = "Warning",
                    text   = string.format("%s is above %d%% (%d%%)", partition, threshold, fs_now[partition].percentage)
                }
                helpers.set_map(partition, true)
            else
                helpers.set_map(partition, false)
            end
        end

        local fmt = "%-" .. tostring(pathlen) .. "s %4s\t%6s\t%6s\n"
        local notifytable = { [1] = string.format(fmt, "path", "used", "free", "size") }
        fmt = "\n%-" .. tostring(pathlen) .. "s %3s%%\t%6.2f\t%6.2f %s"
        for _, path in ipairs(notifypaths) do
            notifytable[#notifytable+1] = string.format(fmt, path, fs_now[path].percentage, fs_now[path].free, fs_now[path].size, fs_now[path].units)
        end

        fs.notification_preset.text = tconcat(notifytable)
    end

    function fs.update(callback)
        Gio.Async.start(gears.protected_call.call)(function()
            update_synced()
            if type(callback) == "function" and callback then
                callback()
            end
        end)
    end

    if showpopup == "on" then
       fs.widget:connect_signal('mouse::enter', function () fs.show(0) end)
       fs.widget:connect_signal('mouse::leave', function () fs.hide() end)
    end

    helpers.newtimer(partition or "fs", timeout, fs.update)

    return fs
end

return factory
