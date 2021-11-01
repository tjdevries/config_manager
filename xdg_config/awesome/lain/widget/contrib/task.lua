--[[

     Licensed under GNU General Public License v2
      * (c) 2013, Jan Xie

--]]

local helpers = require("lain.helpers")
local markup  = require("lain.util").markup
local awful   = require("awful")
local naughty = require("naughty")
local mouse   = mouse

-- Taskwarrior notification
-- lain.widget.contrib.task
local task = {}

function task.hide()
    if not task.notification then return end
    naughty.destroy(task.notification)
    task.notification = nil
end

function task.show(scr)
    task.notification_preset.screen = task.followtag and awful.screen.focused() or scr or 1

    helpers.async({ awful.util.shell, "-c", task.show_cmd }, function(f)
        local widget_focused = true

        if mouse.current_widgets then
            widget_focused = false
            for _,v in ipairs(mouse.current_widgets) do
                if task.widget == v then
                    widget_focused = true
                    break
                end
            end
        end

        if widget_focused then
            task.hide()
            task.notification = naughty.notify {
                preset = task.notification_preset,
                title  = "task next",
                text   = markup.font(task.notification_preset.font,
                         awful.util.escape(f:gsub("\n*$", "")))
            }
        end
    end)
end

function task.prompt()
    awful.prompt.run {
        prompt       = task.prompt_text,
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = function(t)
            helpers.async(t, function(f)
                naughty.notify {
                    preset = task.notification_preset,
                    title  = t,
                    text   = markup.font(task.notification_preset.font,
                             awful.util.escape(f:gsub("\n*$", "")))
                }
            end)
        end,
        history_path = awful.util.getdir("cache") .. "/history_task"
    }
end

function task.attach(widget, args)
    args                     = args or {}

    task.show_cmd            = args.show_cmd or "task next"
    task.prompt_text         = args.prompt_text or "Enter task command: "
    task.followtag           = args.followtag or false
    task.notification_preset = args.notification_preset
    task.widget              = widget

    if not task.notification_preset then
        task.notification_preset = {
            font = "Monospace 10",
            icon = helpers.icons_dir .. "/taskwarrior.png"
        }
    end

    if widget then
        widget:connect_signal("mouse::enter", function () task.show() end)
        widget:connect_signal("mouse::leave", function () task.hide() end)
    end
end

return task
