## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Shows and controls PulseAudio volume.

```lua
local volume = lain.widget.pulse()
```

## Input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout (in seconds) | integer | 5
`devicetype` | PulseAudio device type | string ("sink", "source") | "sink"
`cmd` | PulseAudio command | string or function | see [here](https://github.com/lcpz/lain/blob/master/widget/pulse.lua#L26)
`settings` | User settings | function | empty function
`widget` | Widget to render | function | `wibox.widget.textbox`

`cmd` is a terminal command to catch infos from current default device. You can redefine it, being sure that the ouput is something like this:

```shell
* index: 0
    volume: front-left: 18340 /  28% / -33.18 dB,   front-right: 18340 /  28% / -33.18 dB
    muted: no
    device.string = "front:1"
```

If your devices change dynamically, you can define it as a function which returns a command string.

If sed doesn't work, you can try with a grep variant:

```lua
cmd = "pacmd list-" .. pulse.devicetype .. "s | grep -e $(pactl info | grep -e 'ink' | cut -d' ' -f3) -e 'volume: front' -e 'muted'"
```

### `settings` variables

`settings` can use the following variables:

Variable | Meaning | Type | Values
--- | --- | --- | ---
`volume_now.device` | Device name | string | device name or "N/A"
`volume_now.index` | Device index | string | >= "0"
`volume_now.muted` | Device mute status | string | "yes", "no", "N/A"
`volume_now.channel` | Device channels | table of string integers | `volume_now.channel[i]`, where `i >= 1`
`volume_now.left` | Front left sink level or first source | string | "0"-"100"
`volume_now.right` | Front right sink level or second source | string | "0"-"100"

`volume_now.channel` is a table of your PulseAudio devices. Fetch a channel level like this: `volume_now.channel[i]`, where `i >= 1`.

`volume_now.{left,right}` are pointers for `volume_now.{channel[1], channel[2]}` (stereo).

## Output table

Variable | Meaning | Type
--- | --- | ---
`widget` | The widget | `wibox.widget.textbox`
`update` | Update `widget` | function

## Buttons

```lua
volume.widget:buttons(awful.util.table.join(
    awful.button({}, 1, function() -- left click
        awful.spawn("pavucontrol")
    end),
    awful.button({}, 2, function() -- middle click
        os.execute(string.format("pactl set-sink-volume %s 100%%", volume.device))
        volume.update()
    end),
    awful.button({}, 3, function() -- right click
        os.execute(string.format("pactl set-sink-mute %s toggle", volume.device))
        volume.update()
    end),
    awful.button({}, 4, function() -- scroll up
        os.execute(string.format("pactl set-sink-volume %s +1%%", volume.device))
        volume.update()
    end),
    awful.button({}, 5, function() -- scroll down
        os.execute(string.format("pactl set-sink-volume %s -1%%", volume.device))
        volume.update()
    end)
))
```

## Keybindings

```lua
-- PulseAudio volume control
awful.key({ altkey }, "Up",
    function ()
        os.execute(string.format("pactl set-sink-volume %s +1%%", volume.device))
        volume.update()
    end),
awful.key({ altkey }, "Down",
    function ()
        os.execute(string.format("pactl set-sink-volume %s -1%%", volume.device))
        volume.update()
    end),
awful.key({ altkey }, "m",
    function ()
        os.execute(string.format("pactl set-sink-mute %s toggle", volume.device))
        volume.update()
    end),
awful.key({ altkey, "Control" }, "m",
    function ()
        os.execute(string.format("pactl set-sink-volume %s 100%%", volume.device))
        volume.update()
    end),
awful.key({ altkey, "Control" }, "0",
    function ()
        os.execute(string.format("pactl set-sink-volume %s 0%%", volume.device))
        volume.update()
    end),
```

where `altkey = "Mod1"`.

## Example

```lua
-- PulseAudio volume (based on multicolor theme)
local volume = lain.widget.pulse {
    settings = function()
        vlevel = volume_now.left .. "-" .. volume_now.right .. "% | " .. volume_now.device
        if volume_now.muted == "yes" then
            vlevel = vlevel .. " M"
        end
        widget:set_markup(lain.util.markup("#7493d2", vlevel))
    end
}
```
