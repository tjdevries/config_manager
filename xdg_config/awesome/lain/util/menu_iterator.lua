--[[

     Licensed under GNU General Public License v2
      * (c) 2017, Simon Désaulniers <sim.desaulniers@gmail.com>
      * (c) 2017, Uli Schlachter
      * (c) 2017, Jeferson Siqueira <jefersonlsiq@gmail.com>

--]]

-- Menu iterator with Naughty notifications
-- lain.util.menu_iterator

local naughty = require("naughty")
local helpers = require("lain.helpers")
local atable  = require("awful.util").table
local assert  = assert
local pairs   = pairs
local tconcat = table.concat
local unpack = unpack or table.unpack -- lua 5.1 retro-compatibility

local state = { cid = nil }

local function naughty_destroy_callback(reason)
    local closed = naughty.notificationClosedReason
    if reason == closed.expired or reason == closed.dismissedByUser then
        local actions = state.index and state.menu[state.index - 1][2]
        if actions then
            for _,action in pairs(actions) do
                -- don't try to call nil callbacks
                if action then action() end
            end
            state.index = nil
        end
    end
end

-- Iterates over a menu.
-- After the timeout, callbacks associated to the last visited choice are
-- executed. Inputs:
-- * menu:    a list of {label, {callbacks}} pairs
-- * timeout: time to wait before confirming the menu selection
-- * icon:    icon to display in the notification of the chosen label
local function iterate(menu, timeout, icon)
    timeout = timeout or 4 -- default timeout for each menu entry
    icon    = icon or nil  -- icon to display on the menu

    -- Build the list of choices
    if not state.index then
        state.menu = menu
        state.index = 1
    end

    -- Select one and display the appropriate notification
    local label
    local next = state.menu[state.index]
    state.index = state.index + 1

    if not next then
        label = "Cancel"
        state.index = nil
    else
        label, _ = unpack(next)
    end

    state.cid = naughty.notify({
        text        = label,
        icon        = icon,
        timeout     = timeout,
        screen      = mouse.screen,
        replaces_id = state.cid,
        destroy     = naughty_destroy_callback
    }).id
end

-- Generates a menu compatible with the first argument of `iterate` function and
-- suitable for the following cases:
-- * all possible choices individually (partition of singletons);
-- * all possible subsets of the set of choices (powerset).
--
-- Inputs:
-- * args: an array containing the following members:
--   * choices:       Array of choices (string) on which the menu will be
--                    generated.
--   * name:          Displayed name of the menu (in the form "name: choices").
--   * selected_cb:   Callback to execute for each selected choice. Takes
--                    the choice as a string argument. Can be `nil` (no action
--                    to execute).
--   * rejected_cb:   Callback to execute for each rejected choice (possible
--                    choices which are not selected). Takes the choice as a
--                    string argument. Can be `nil` (no action to execute).
--   * extra_choices: An array of extra { choice_str, callback_fun } pairs to be
--                    added to the menu. Each callback_fun can be `nil`.
--   * combination:   The combination of choices to generate. Possible values:
--                    "powerset" and "single" (default).
-- Output:
-- * m: menu to be iterated over.
local function menu(args)
    local choices       = assert(args.choices or args[1])
    local name          = assert(args.name or args[2])
    local selected_cb   = args.selected_cb
    local rejected_cb   = args.rejected_cb
    local extra_choices = args.extra_choices or {}

    local ch_combinations = args.combination == "powerset" and helpers.powerset(choices) or helpers.trivial_partition_set(choices)

    for _, c in pairs(extra_choices) do
        ch_combinations = atable.join(ch_combinations, {{c[1]}})
    end

    local m = {} -- the menu

    for _,c in pairs(ch_combinations) do
        if #c > 0 then
            local cbs = {}

            -- selected choices
            for _,ch in pairs(c) do
                if atable.hasitem(choices, ch) then
                    cbs[#cbs + 1] = selected_cb and function() selected_cb(ch) end or nil
                end
            end

            -- rejected choices
            for _,ch in pairs(choices) do
                if not atable.hasitem(c, ch) and atable.hasitem(choices, ch) then
                    cbs[#cbs + 1] = rejected_cb and function() rejected_cb(ch) end or nil
                end
            end

            -- add user extra choices (like the choice "None" for example)
            for _,x in pairs(extra_choices) do
                if x[1] == c[1] then
                    cbs[#cbs + 1] = x[2]
                end
            end

            m[#m + 1] = { name .. ": " .. tconcat(c, " + "), cbs }
        end
    end

    return m
end

return { iterate = iterate, menu = menu }
