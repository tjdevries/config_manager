## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Shows ALSA volume with a progressbar; provides tooltips and notifications.

```lua
local volume = lain.widget.alsabar()
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
`ticks_size` | Ticks size | integer | 7
`tick` | String for a notification tick | string | "|"
`tick_pre` | String for the left notification delimeter | string | "["
`tick_post` | String for the right notification delimeter | string | "]"
`tick_none` | String for an empty notification tick | string | " "
`cmd` | ALSA mixer command | string | "amixer"
`channel` | Mixer channel | string | "Master"
`togglechannel` | Toggle channel | string | `nil`
`tick` | The character usef for ticks in the notification | string | "|"
`colors` | Bar colors | table | see [Default colors](https://github.com/lcpz/lain/wiki/alsabar#default-colors)
`notification_preset` | Notification preset | table | See [default `notification_preset`](https://github.com/lcpz/lain/wiki/alsabar#default-notification_preset)
`followtag` | Display the notification on currently focused screen | boolean | false

`cmd` is useful if you need to pass additional arguments to  `amixer`. For instance, you may want to define `cmd = "amixer -c X"` in order to set amixer with card `X`.

In case mute toggling can't be mapped to master channel (this happens, for instance, when you are using an HDMI output), define `togglechannel` as your S/PDIF device. Read [`alsa`](https://github.com/lcpz/lain/wiki/alsa#toggle-channel) page to know how.

To set the maximum number of ticks to display in the notification, define `max_ticks` (integer) in `notification_preset`.

`settings` can use the following variables:

Variable | Meaning | Type | Values
--- | --- | --- | ---
`volume_now.level` | Volume level | integer | 0-100
`volume_now.status` | Device status | string | "on", "off"

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
`channel` | ALSA channel | string
`notify` | The notification | function
`update` | Update `bar` | function
`tooltip` | The tooltip | `awful.tooltip`

## Buttons

If you want buttons, just add the following after your widget in `rc.lua`.

```lua
volume.bar:buttons(awful.util.table.join(
    awful.button({}, 1, function() -- left click
        awful.spawn(string.format("%s -e alsamixer", terminal))
    end),
    awful.button({}, 2, function() -- middle click
        os.execute(string.format("%s set %s 100%%", volume.cmd, volume.channel))
        volume.update()
    end),
    awful.button({}, 3, function() -- right click
        os.execute(string.format("%s set %s toggle", volume.cmd, volume.togglechannel or volume.channel))
        volume.update()
    end),
    awful.button({}, 4, function() -- scroll up
        os.execute(string.format("%s set %s 1%%+", volume.cmd, volume.channel))
        volume.update()
    end),
    awful.button({}, 5, function() -- scroll down
        os.execute(string.format("%s set %s 1%%-", volume.cmd, volume.channel))
        volume.update()
    end)
))
```

## Keybindings

Read [here](https://github.com/lcpz/lain/wiki/alsa#keybindings). If you want notifications, use `volume.notify()` instead of `volume.update()`.
