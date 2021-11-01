--[[

     Licensed under GNU General Public License v2
      * (c) 2013, Luca CPZ

--]]

local helpers  = require("lain.helpers")
local naughty  = require("naughty")
local wibox    = require("wibox")
local awful    = require("awful")
local string   = string
local type     = type
local tonumber = tonumber

-- Mail IMAP check
-- lain.widget.imap

local function factory(args)
    args             = args or {}

    local imap       = { widget = args.widget or wibox.widget.textbox() }
    local server     = args.server
    local mail       = args.mail
    local password   = args.password
    local port       = args.port or 993
    local timeout    = args.timeout or 60
    local pwdtimeout = args.pwdtimeout or 10
    local is_plain   = args.is_plain or false
    local followtag  = args.followtag or false
    local notify     = args.notify or "on"
    local settings   = args.settings or function() end

    local head_command = "curl --connect-timeout 3 -fsm 3"
    local request = "-X 'STATUS INBOX (MESSAGES RECENT UNSEEN)'"

    if not server or not mail or not password then return end

    mail_notification_preset = {
        icon     = helpers.icons_dir .. "mail.png",
        position = "top_left"
    }

    helpers.set_map(mail, 0)

    if not is_plain then
        if type(password) == "string" or type(password) == "table" then
            helpers.async(password, function(f) password = f:gsub("\n", "") end)
        elseif type(password) == "function" then
            imap.pwdtimer = helpers.newtimer(mail .. "-password", pwdtimeout, function()
                local retrieved_password, try_again = password()
                if not try_again then
                    imap.pwdtimer:stop() -- stop trying to retrieve
                    password = retrieved_password or "" -- failsafe
                end
            end, true, true)
        end
    end

    function imap.update()
        -- do not update if the password has not been retrieved yet
        if type(password) ~= "string" then return end

        local curl = string.format("%s --url imaps://%s:%s/INBOX -u %s:'%s' %s -k",
                     head_command, server, port, mail, password, request)

        helpers.async(curl, function(f)
            imap_now = { ["MESSAGES"] = 0, ["RECENT"] = 0, ["UNSEEN"] = 0 }

            for s,d in f:gmatch("(%w+)%s+(%d+)") do imap_now[s] = tonumber(d) end
            mailcount = imap_now["UNSEEN"] -- backwards compatibility
            widget = imap.widget

            settings()

            if notify == "on" and mailcount and mailcount >= 1 and mailcount > helpers.get_map(mail) then
                if followtag then mail_notification_preset.screen = awful.screen.focused() end
                naughty.notify {
                    preset = mail_notification_preset,
                    text   = string.format("%s has <b>%d</b> new message%s", mail, mailcount, mailcount == 1 and "" or "s")
                }
            end

            helpers.set_map(mail, imap_now["UNSEEN"])
        end)

    end

    imap.timer = helpers.newtimer(mail, timeout, imap.update, true, true)

    return imap
end

return factory
