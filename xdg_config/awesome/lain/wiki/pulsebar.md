## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Shows PulseAudio volume with a progressbar; provides tooltips and notifications.

```lua
local volume = lain.widget.pulsebar()
```

## Input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout (in seconds) | integer | 5
`settings` | User settings | function | empty function
`width` | Bar width | number | 63
`height` | Bar height | number | 1
`margins` | Bar margins | number | 1
`paddings` | Bar paddings | number | 1
`ticks` | Set bar ticks on | boolean | false
`ticks_size` | Ticks size | number | 7
`tick` | String for a notification tick | string | "|"
`tick_pre` | String for the left notification delimeter | string | "["
`tick_post` | String for the right notification delimeter | string | "]"
`tick_none` | String for an empty notification tick | string | " "
`scallback` | [PulseAudio sink callback](https://github.com/lcpz/lain/wiki/pulseaudio/) | function | `nil`
`sink` | Mixer sink | number | 0
`colors` | Bar colors | table | see [Default colors](https://github.com/lcpz/lain/wiki/pulsebar#default-colors)
`notification_preset` | Notification preset | table | See [default `notification_preset`](https://github.com/lcpz/lain/wiki/pulsebar#default-notification_preset)
`followtag` | Display the notification on currently focused screen | boolean | false
`notification_preset` | Notification preset | table | See [default `notification_preset`](https://github.com/lcpz/lain/wiki/pulsebar#default-notification_preset)
`devicetype` | PulseAudio device type | string ("sink", "source") | "sink"
`cmd` | PulseAudio command | string or function | see [here](https://github.com/lcpz/lain/blob/master/widget/pulsebar.lua#L48)

Read [pulse](https://github.com/lcpz/lain/wiki/pulse) page for `cmd` settings.

`settings` can use [these variables](https://github.com/lcpz/lain/wiki/pulse#settings-variables).

With multiple screens, the default behaviour is to show a visual notification pop-up window on the first screen. By setting `followtag` to `true` it will be shown on the currently focused tag screen.

### Default colors

Variable | Meaning | Type | Default
--- | --- | --- | ---
`background` | Bar backgrund color | string | "#000000"
`mute` | Bar mute color | string | "#EB8F8F"
`unmute` | Bar unmute color | string | "#A4CE8A"

### Default `notification_preset`

```lua
notification_preset = {
    font = "Monospace 10"
}
```

## Output table

Variable | Meaning | Type
--- | --- | ---
`bar` | The widget | `wibox.widget.progressbar`
`device` | PulseAudio device | string
`notify` | The notification | function
`update` | Update state | function
`tooltip` | The tooltip | `awful.tooltip`

## Buttons

```lua
volume.bar:buttons(awful.util.table.join(
    awful.button({}, 1, function() -- left click
        awful.spawn("pavucontrol")
    end),
    awful.button({}, 2, function() -- middle click
        os.execute(string.format("pactl set-sink-volume %d 100%%", volume.device))
        volume.update()
    end),
    awful.button({}, 3, function() -- right click
        os.execute(string.format("pactl set-sink-mute %d toggle", volume.device))
        volume.update()
    end),
    awful.button({}, 4, function() -- scroll up
        os.execute(string.format("pactl set-sink-volume %d +1%%", volume.device))
        volume.update()
    end),
    awful.button({}, 5, function() -- scroll down
        os.execute(string.format("pactl set-sink-volume %d -1%%", volume.device))
        volume.update()
    end)
))
```

## Keybindings

Same as [here](https://github.com/lcpz/lain/wiki/pulse#keybindings). If you want notifications, use `volume.notify()` instead of `volume.update()`.
