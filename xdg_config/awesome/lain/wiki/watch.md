## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Template for asynchronous watcher widgets.

Executes an input command and makes the user feed a `wibox.widget` with the output.

```lua
local mywatch = lain.widget.watch()
```

This has been implemented in Awesome 4.0 as [`awful.widget.watch`](https://awesomewm.org/doc/api/classes/awful.widget.watch.html). But while Awesome `watch` returns only the widget, Lain one returns a table including its timer and internal update function too.

## Input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`widget` | Widget to feed | `wibox.widget` | `wibox.widget.textbox`
`timeout` | Refresh timeout seconds | number | 5
`cmd` | The command to execute | string **or** table | `nil`
`nostart` | Widget timer doesn't start immediately | boolean | false
`stoppable` | Widget timer is stoppable | boolean | false
`settings` | User settings | function | see [Default `settings` function](https://github.com/lcpz/lain/wiki/watch#default-settings-function)

If your command needs a shell, you need to set `cmd` as an array of 3 strings, where the first contains the shell, the second contains `-c`, and the third contains the actual command. Example:

```lua
cmd = { awful.util.shell, "-c", "myactualcommand" }
```

`settings` can use the string `output`, which is the output of `cmd`.

### Default `settings` function

```lua
settings = function() widget:set_text(output) end
```
## Output table

Variable | Meaning | Type
--- | --- | ---
`widget` | The widget | input widget type or `wibox.widget.textbox`
`update` | Update `widget` | function
`timer` | The widget timer | [`gears.timer`](https://awesomewm.org/doc/api/classes/gears.timer.html) or `nil`

The `update` function can be used to refresh the widget before `timeout` expires.

If `stoppable == true`, the widget will have an ad-hoc timer, which you can control though `timer` variable.

## Use case examples

### bitcoin

```lua
-- Bitcoin to USD current price, using Coinbase V1 API
local bitcoin = lain.widget.watch({
    timeout = 43200, -- half day
    stoppable = true,
    cmd = "curl -m5 -s 'https://coinbase.com/api/v1/prices/buy'",
    settings = function()
        local btc, pos, err = require("lain.util").dkjson.decode(output, 1, nil)
        local btc_price = (not err and btc and btc["subtotal"]["amount"]) or "N/A"

        -- customize here
        widget:set_text(btc_price)
    end
})
```

### btrfs

```lua
-- btrfs root df
local myrootfs = lain.widget.watch({
    timeout = 600,
    cmd = "btrfs filesystem df -g /",
    settings  = function()
        local total, used  = string.match(output, "Data.-total=(%d+%.%d+)GiB.-used=(%d+%.%d+)GiB")
        local percent_used = math.ceil((tonumber(used) / tonumber(total)) * 100)

        -- customize here
        widget:set_text(" [/: " .. percent_used .. "%] ")
    end
})
```

### cmus

```lua
-- cmus audio player
local cmus = lain.widget.watch({
    timeout = 2,
    stoppable = true,
    cmd = "cmus-remote -Q",
    settings = function()
        local cmus_now = {
            state   = "N/A",
            artist  = "N/A",
            title   = "N/A",
            album   = "N/A"
        }

        for w in string.gmatch(output, "(.-)tag") do
            a, b = w:match("(%w+) (.-)\n")
            cmus_now[a] = b
        end

        -- customize here
        widget:set_text(cmus_now.artist .. " - " .. cmus_now.title)
    end
})
```

### maildir

```lua
-- checks whether there are files in the "new" directories of a mail dirtree
local mailpath = "~/Mail"
local mymaildir = lain.widget.watch({
    timeout = 60,
    stoppable = true,
    cmd = { awful.util.shell, "-c", string.format("ls -1dr %s/*/new/*", mailpath) },
    settings = function()
        local inbox_now = { digest = "" }

        for dir in output:gmatch(".-/(%w+)/new") do
            inbox_now[dir] = 1
            for _ in output:gmatch(dir) do
                inbox_now[dir] = inbox_now[dir] + 1
            end
            if #inbox_now.digest > 0 then inbox_now.digest = inbox_now.digest .. ", " end
            inbox_now.digest = inbox_now.digest .. string.format("%s (%d)", dir, inbox_now[dir])
        end

        -- customize here
        widget:set_text("mail: " .. inbox_now.digest)
    end
})
```

### mpris

```lua
-- infos from mpris clients such as spotify and VLC
-- based on https://github.com/acrisci/playerctl
local mpris = lain.widget.watch({
    cmd = "playerctl status && playerctl metadata",
    timeout = 2,
    stoppable = true,
    settings = function()
         local escape_f  = require("awful.util").escape
         local mpris_now = {
             state        = "N/A",
             artist       = "N/A",
             title        = "N/A",
             art_url      = "N/A",
             album        = "N/A",
             album_artist = "N/A"
         }

         mpris_now.state = string.match(output, "Playing") or
                           string.match(output, "Paused")  or "N/A"

         for k, v in string.gmatch(output, "'[^:]+:([^']+)':[%s]<%[?'([^']+)'%]?>")
         do
             if     k == "artUrl"      then mpris_now.art_url      = v
             elseif k == "artist"      then mpris_now.artist       = escape_f(v)
             elseif k == "title"       then mpris_now.title        = escape_f(v)
             elseif k == "album"       then mpris_now.album        = escape_f(v)
             elseif k == "albumArtist" then mpris_now.album_artist = escape_f(v)
             end
         end

        -- customize here
        widget:set_text(mpris_now.artist .. " - " .. mpris_now.title)
    end
})
```

### upower

```lua
-- battery infos from freedesktop upower
local mybattery = lain.widget.watch({
    timeout = 30,
    cmd = { awful.util.shell, "-c", "upower -i /org/freedesktop/UPower/devices/battery_BAT | sed -n '/present/,/icon-name/p'" },
    settings = function()
        local bat_now = {
            present      = "N/A",
            state        = "N/A",
            warninglevel = "N/A",
            energy       = "N/A",
            energyfull   = "N/A",
            energyrate   = "N/A",
            voltage      = "N/A",
            percentage   = "N/A",
            capacity     = "N/A",
            icon         = "N/A"
        }

        for k, v in string.gmatch(output, '([%a]+[%a|-]+):%s*([%a|%d]+[,|%a|%d]-)') do
            if     k == "present"       then bat_now.present      = v
            elseif k == "state"         then bat_now.state        = v
            elseif k == "warning-level" then bat_now.warninglevel = v
            elseif k == "energy"        then bat_now.energy       = string.gsub(v, ",", ".") -- Wh
            elseif k == "energy-full"   then bat_now.energyfull   = string.gsub(v, ",", ".") -- Wh
            elseif k == "energy-rate"   then bat_now.energyrate   = string.gsub(v, ",", ".") -- W
            elseif k == "voltage"       then bat_now.voltage      = string.gsub(v, ",", ".") -- V
            elseif k == "percentage"    then bat_now.percentage   = tonumber(v)              -- %
            elseif k == "capacity"      then bat_now.capacity     = string.gsub(v, ",", ".") -- %
            elseif k == "icon-name"     then bat_now.icon         = v
            end
        end

        -- customize here
        widget:set_text("Bat: " .. bat_now.percentage .. " " .. bat_now.state)
    end
})
```
