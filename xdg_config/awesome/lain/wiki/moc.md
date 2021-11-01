## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

A widget for showing the current song track's information from MOC (Music On Console).

```lua
local mymoc = lain.widget.contrib.moc()
```

Now playing songs are notified like this:

	+--------------------------------------------------------+
	| +-------+                                              |
	| |/^\_/^\| Now playing                                  |
    | |\ O O /| Cannibal Corpse (Hammer Smashed Face) - 1993 |
    | | '.o.' | Hammer Smashed Face (Radio Disney Version)   |
	| +-------+                                              |
	+--------------------------------------------------------+

## Input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout (in seconds) | integer | 1
`music_dir` | Music directory | string | "~/Music"
`cover_size` | Album art notification size (both height and width) | integer | 100
`cover_pattern` | Pattern for the album art file | string | `*\\.(jpg|jpeg|png|gif)`*
`default_art` | Default art | string | ""
`followtag` | Display the notification on currently focused screen | boolean | false
`settings` | User settings | function | empty function
`widget` | Widget to render | function | `wibox.widget.textbox`

\* In Lua, "\\\\" means "\" escaped.

Default `cover_pattern` definition will made the widget set the first jpg, jpeg, png or gif file found in the directory as the album art.

Pay attention to case sensitivity when defining `music_dir`.

`settings` can use `moc_now` table, which contains the following string values:

- state (possible values: "PLAY", "PAUSE", "STOP")
- file
- artist
- title
- album
- elapsed (Time elapsed for the current track)
- total (The current track's total time)

and can modify `moc_notification_preset` table, which will be the preset for the naughty notifications. Check [here](https://awesomewm.org/apidoc/libraries/naughty.html#notify) for the list of variables it can contain. Default definition:

```lua
moc_notification_preset = {
    title   = "Now playing",
    timeout = 6,
    text    = string.format("%s (%s) - %s\n%s", moc_now.artist,
              moc_now.album, moc_now.elapsed, moc_now.title)
}
```

With multiple screens, the default behaviour is to show a visual notification pop-up window on the first screen. By setting `followtag` to `true` it will be shown on the currently focused tag screen.

## Output table

Variable | Meaning | Type
--- | --- | ---
`widget` | The widget | `wibox.widget.textbox`
`update` | Update `widget` | function
`timer` | The widget timer | [`gears.timer`](https://awesomewm.org/doc/api/classes/gears.timer.html)

The `update` function can be used to refresh the widget before `timeout` expires.

You can use `timer` to start/stop the widget as you like.

## Keybindings

You can control the widget with key bindings like these:

```lua
-- MOC control
awful.key({ altkey, "Control" }, "Up",
	function ()
		os.execute("mocp -G") -- toggle
		moc.update()
	end),
awful.key({ altkey, "Control" }, "Down",
	function ()
		os.execute("mocp -s") -- stop
		moc.update()
	end),
awful.key({ altkey, "Control" }, "Left",
	function ()
		os.execute("mocp -r") -- previous
		moc.update()
	end),
awful.key({ altkey, "Control" }, "Right",
	function ()
		os.execute("mocp -f") -- next
		moc.update()
	end),
```

where `altkey = "Mod1"`.

If you don't use the widget for long periods and wish to spare CPU, you can toggle it with a keybinding like this:

```lua
-- toggle MOC widget
awful.key({ altkey }, "0",
        function ()
            local common = { text = "MOC widget ", position = "top_middle", timeout = 2 }
            if moc.timer.started then
                moc.timer:stop()
                common.text = common.text .. markup.bold("OFF")
            else
                moc.timer:start()
                common.text = common.text .. markup.bold("ON")
            end
            naughty.notify(common)
        end),
```
