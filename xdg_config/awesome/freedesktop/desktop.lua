--[[

     Awesome-Freedesktop
     Freedesktop.org compliant desktop entries and menu

     Desktop section

     Licensed under GNU General Public License v2
      * (c) 2016,      Luke Bonham
      * (c) 2009-2015, Antonio Terceiro

--]]

local awful  = require("awful")
local theme  = require("beautiful")
local utils  = require("menubar.utils")
local wibox  = require("wibox")

local io     = io
local ipairs = ipairs
local mouse  = mouse
local os     = os
local string = string
local screen = screen
local table  = table

-- Desktop icons
-- freedesktop.desktop
local desktop = {
    -- Default desktop basic icons
    baseicons = {
        [1] = {
            label = "This PC",
            icon  = "computer",
            onclick = "computer://"
        },
        [2] = {
            label = "Home",
            icon  = "user-home",
            onclick = os.getenv("HOME")
        },
        [3] = {
            label = "Trash",
            icon  = "user-trash",
            onclick = "trash://"
        }
    },
    -- Default parameters
    iconsize   = { width = 48,  height = 48 },
    labelsize  = { width = 140, height = 20 },
    margin     = { x = 20, y = 20 },
}

-- MIME types list
local mime_types = {}

-- Icons positioning
local desktop_current_pos = {}

-- @return iterator on input pipe
local function pipelines(...)
    local f = assert(io.popen(...))
    return function ()
        local data = f:read()
        if data == nil then f:close() end
        return data
    end
end

-- Adds an icon to desktop
-- @param args settings from desktop.add_icons
-- @param label icon string label
-- @param icon icon string file path
-- @param onclick function to execute on click
function desktop.add_single_icon(args, label, icon, onclick)
    local s = args.screen

    -- define icon dimensions and position
    if not desktop_current_pos[s] then
        desktop_current_pos[s] = { x = (screen[s].geometry.x + args.iconsize.width + args.margin.x), y = 40 }
    end

    local totheight = (icon and args.iconsize.height or 0) + (label and args.labelsize.height or 0)
    if totheight == 0 then return end

    if desktop_current_pos[s].y + totheight > screen[s].geometry.height - 40 then
        desktop_current_pos[s].x = desktop_current_pos[s].x + args.labelsize.width + args.iconsize.width + args.margin.x
        desktop_current_pos[s].y = 40
    end

    local common = { screen = s, bg = "#00000000", visible = true, type = "desktop" }

    -- create icon container
    if icon then
        common.width = args.iconsize.width
        common.height = args.iconsize.height
        common.x = desktop_current_pos[s].x
        common.y = desktop_current_pos[s].y

        icon = wibox.widget {
            image = icon,
            resize = false,
            widget = wibox.widget.imagebox
        }

        icon:buttons(awful.button({ }, 1, nil, onclick))

        icon_container = wibox(common)
        icon_container:set_widget(icon)

        desktop_current_pos[s].y = desktop_current_pos[s].y + args.iconsize.height + 5
    end

    -- create label container
    if label then
        common.width = args.labelsize.width
        common.height = args.labelsize.height
        common.x = desktop_current_pos[s].x - (args.labelsize.width/2) + args.iconsize.width/2
        common.y = desktop_current_pos[s].y

        caption = wibox.widget {
            text          = label,
            align         = "center",
            forced_width  = common.width,
            forced_height = common.height,
            ellipsize     = "middle",
            widget        = wibox.widget.textbox
        }

        caption:buttons(awful.button({ }, 1, onclick))
        caption_container = wibox(common)
        caption_container:set_widget(caption)
    end

    desktop_current_pos[s].y = desktop_current_pos[s].y + args.labelsize.height + args.margin.y
end

-- Adds base icons (This PC, Trash, etc) to desktop
-- @param args settings from desktop.add_icons
function desktop.add_base_icons(args)
    for _,base in ipairs(args.baseicons) do
        desktop.add_single_icon(args, base.label, utils.lookup_icon(base.icon), function()
            awful.spawn(string.format("%s '%s'", args.open_with, base.onclick))
        end)
    end
end

-- Looks up a suitable icon for filename
-- @param filename string file name
-- @return icon file path (string)
function desktop.lookup_file_icon(filename)
    -- load system MIME types
    if #mime_types == 0 then
        for line in io.lines("/etc/mime.types") do
            if not line:find("^#") then
                local parsed = {}
                for w in line:gmatch("[^%s]+") do
                    table.insert(parsed, w)
                end
                if #parsed > 1 then
                    for i = 2, #parsed do
                        mime_types[parsed[i]] = parsed[1]:gsub("/", "-")
                    end
                end
            end
        end
    end

    -- try to search a possible icon among standards
    local extension = filename:match("%a+$")
    local mime = mime_types[extension] or ""
    local mime_family = mime:match("^%a+") or ""

    local possible_filenames = {
        mime, "gnome-mime-" .. mime,
        mime_family, "gnome-mime-" .. mime_family,
        extension
    }

    for i, filename in ipairs(possible_filenames) do
        local icon = utils.lookup_icon(filename)
        if icon then return icon end
    end

    -- if we don"t find ad icon, then pretend is a plain text file
    return utils.lookup_icon("text-x-generic")
end

-- Parse subdirectories and files list from input directory
-- @input dir directory to parse (string)
-- @return files table with found entries
function desktop.parse_dirs_and_files(dir)
    local files = {}
    local paths = pipelines('find '..dir..' -maxdepth 1 -type d | tail -1')
    for path in paths do
        if path:match("[^/]+$") then
            local file = {}
            file.filename = path:match("[^/]+$")
            file.path = path
            file.show = true
            file.icon = utils.lookup_icon("folder")
            table.insert(files, file)
        end
    end
    local paths = pipelines('find '..dir..' -maxdepth 1 -type f')
    for path in paths do
        if not path:find("%.desktop$") then
            local file = {}
            file.filename = path:match("[^/]+$")
            file.path = path
            file.show = true
            file.icon = desktop.lookup_file_icon(file.filename)
            table.insert(files, file)
        end
    end
    return files
end

-- Adds subdirectories and files icons from args.dir
-- @param args settings from desktop.add_icons
function desktop.add_dirs_and_files_icons(args)
    for _, file in ipairs(desktop.parse_dirs_and_files(args.dir)) do
        if file.show then
            local label = args.showlabels and file.filename or nil
            local onclick = function () awful.spawn(string.format("%s '%s'", args.open_with, file.path)) end
            desktop.add_single_icon(args, label, file.icon, onclick)
        end
    end
end

-- Main function, adds base, directory and files icons
-- @param args user defined settings, with fallback on defaults
function desktop.add_icons(args)
    args            = args or {}
    args.screen     = args.screen or mouse.screen
    args.dir        = args.dir or os.getenv("HOME") .. "/Desktop"
    args.showlabels = args.showlabel or true
    args.open_with  = args.open_with or "xdg_open"
    args.baseicons  = args.baseicons or desktop.baseicons
    args.iconsize   = args.iconsize or desktop.iconsize
    args.labelsize  = args.labelsize or desktop.labelsize
    args.margin     = args.margin or desktop.margin

    -- trying to fallback on Adwaita if theme.icon_theme is not defined
    -- if Adwaita is missing too, no icons will be shown
    if not theme.icon_theme then
        theme.icon_theme = args.icon_theme or "Adwaita"
    end

    desktop.add_base_icons(args)
    desktop.add_dirs_and_files_icons(args)
end

return desktop
