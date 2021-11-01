## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Shows ALSA volume.

```lua
local volume = lain.widget.alsa()
```

## Input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout (in seconds) | integer | 5
`cmd` | Alsa mixer command | string | "amixer"
`channel` | Mixer channel | string | "Master"
`togglechannel` | Toggle channel | string | `nil`
`settings` | User settings | function | empty function
`widget` | Widget to render | function | `wibox.widget.textbox`

`cmd` is useful if you need to pass additional arguments to amixer. For instance, you may want to define `cmd = "amixer -c X"` in order to set amixer with card `X`.

`settings` can use the following variables:

Variable | Meaning | Type | Values
--- | --- | --- | ---
`volume_now.level` | Volume level | integer | 0-100
`volume_now.status` | Device status | string | "on", "off"

## Output table

Variable | Meaning | Type
--- | --- | ---
`widget` | The widget | `wibox.widget.textbox`
`channel` | ALSA channel | string
`update` | Update `widget` | function

## Toggle channel

In case mute toggling can't be mapped to master channel (this happens, for instance, when you are using an HDMI output), define togglechannel as your S/PDIF device. You can get the device ID with `scontents` command.

For instance, if card number is 1 and S/PDIF number is 3:

```shell
$ amixer -c 1 scontents
Simple mixer control 'Master',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 255
  Front Left: 255 [100%]
  Front Right: 255 [100%]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',2
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',3
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
```

you have to set `togglechannel = "IEC958,3"`.

## Buttons

If you want buttons, just add the following after your widget in `rc.lua`.

```lua
volume.widget:buttons(awful.util.table.join(
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

You can control the widget with keybindings like these:

```lua
-- ALSA volume control
awful.key({ altkey }, "Up",
	function ()
		os.execute(string.format("amixer set %s 1%%+", volume.channel))
		volume.update()
	end),
awful.key({ altkey }, "Down",
	function ()
		os.execute(string.format("amixer set %s 1%%-", volume.channel))
		volume.update()
	end),
awful.key({ altkey }, "m",
	function ()
		os.execute(string.format("amixer set %s toggle", volume.togglechannel or volume.channel))
		volume.update()
	end),
awful.key({ altkey, "Control" }, "m",
	function ()
		os.execute(string.format("amixer set %s 100%%", volume.channel))
		volume.update()
	end),
awful.key({ altkey, "Control" }, "0",
	function ()
		os.execute(string.format("amixer set %s 0%%", volume.channel))
		volume.update()
	end),
```

where `altkey = "Mod1"`.

### Muting with PulseAudio

If you are using this widget in conjuction with PulseAudio, add the option `-D pulse` to the muting keybinding, like this:

```lua
awful.key({ altkey }, "m",
	function ()
		os.execute(string.format("amixer -D pulse set %s toggle", volume.togglechannel or volume.channel))
		volume.update()
	end),
```
