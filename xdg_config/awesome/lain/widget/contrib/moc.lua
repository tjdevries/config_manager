--[[

     Licensed under GNU General Public License v2
      * (c) 2014, anticlockwise <http://github.com/anticlockwise>

--]]

local helpers      = require("lain.helpers")
local shell        = require("awful.util").shell
local focused      = require("awful.screen").focused
local escape_f     = require("awful.util").escape
local naughty      = require("naughty")
local wibox        = require("wibox")
local os           = os
local string       = string

-- MOC audio player
-- lain.widget.contrib.moc

local function factory(args)
    args                = args or {}

    local moc           = { widget = args.widget or wibox.widget.textbox() }
    local timeout       = args.timeout or 2
    local music_dir     = args.music_dir or os.getenv("HOME") .. "/Music"
    local cover_pattern = args.cover_pattern or "*\\.(jpg|jpeg|png|gif)$"
    local cover_size    = args.cover_size or 100
    local default_art   = args.default_art or ""
    local followtag     = args.followtag or false
    local settings      = args.settings or function() end

    moc_notification_preset = { title = "Now playing", timeout = 6 }

    helpers.set_map("current moc track", nil)

    function moc.update()
        helpers.async("mocp -i", function(f)
            moc_now = {
                state   = "N/A",
                file    = "N/A",
                artist  = "N/A",
                title   = "N/A",
                album   = "N/A",
                elapsed = "N/A",
                total   = "N/A"
            }

            for line in string.gmatch(f, "[^\n]+") do
                for k, v in string.gmatch(line, "([%w]+):[%s](.*)$") do
                    if     k == "State"       then moc_now.state   = v
                    elseif k == "File"        then moc_now.file    = v
                    elseif k == "Artist"      then moc_now.artist  = escape_f(v)
                    elseif k == "SongTitle"   then moc_now.title   = escape_f(v)
                    elseif k == "Album"       then moc_now.album   = escape_f(v)
                    elseif k == "CurrentTime" then moc_now.elapsed = escape_f(v)
                    elseif k == "TotalTime"   then moc_now.total   = escape_f(v)
                    end
                end
            end

            moc_notification_preset.text = string.format("%s (%s) - %s\n%s", moc_now.artist,
                                           moc_now.album, moc_now.total, moc_now.title)
            widget = moc.widget
            settings()

            if moc_now.state == "PLAY" then
                if moc_now.title ~= helpers.get_map("current moc track") then
                    helpers.set_map("current moc track", moc_now.title)

                    if followtag then moc_notification_preset.screen = focused() end

                    local common =  {
                        preset      = moc_notification_preset,
                        icon        = default_art,
                        icon_size   = cover_size,
                        replaces_id = moc.id,
                    }

                    local path   = string.format("%s/%s", music_dir, string.match(moc_now.file, ".*/"))
                    local cover  = string.format("find '%s' -maxdepth 1 -type f | egrep -i -m1 '%s'", path, cover_pattern)
                    helpers.async({ shell, "-c", cover }, function(current_icon)
                        common.icon = current_icon:gsub("\n", "")
                        moc.id = naughty.notify(common).id
                    end)
                end
            elseif  moc_now.state ~= "PAUSE" then
                helpers.set_map("current moc track", nil)
            end
        end)
    end

    moc.timer = helpers.newtimer("moc", timeout, moc.update, true, true)

    return moc
end

return factory
