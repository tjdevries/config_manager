## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Shows MPD status.

```lua
local mympd = lain.widget.mpd()
```

Now playing songs are notified like this:

	+--------------------------------------------------------+
	| +-------+                                              |
	| |/^\_/^\| Now playing                                  |
    | |\ O O /| Cannibal Corpse (Hammer Smashed Face) - 1993 |
    | | '.o.' | Hammer Smashed Face (Radio Disney Version)   |
	| +-------+                                              |
	+--------------------------------------------------------+

**Note:** if MPD is turned off or not set correctly, the widget will constantly display "N/A" values.

## Input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout (in seconds) | integer | 2
`password` | MPD password | string | ""
`host` | MPD server | string | "127.0.0.1"
`port` | MPD port | string | "6600"
`music_dir` | Music directory | string | "~/Music"
`cover_size` | Album art notification size (both height and width) | integer | 100
`cover_pattern` | Pattern for the album art file | string | `*.(jpg\|jpeg\|png\|gif)$`
`default_art` | Default art | string | `nil`
`notify` | Show notification popups | string | "on"
`followtag` | Notification behaviour | boolean | false
`settings` | User settings | function | empty function
`widget` | Widget to render | function | `wibox.widget.textbox`

\* In Lua, "\\\\" means "\" escaped.

Default `cover_pattern` definition will made the widget set the first jpg, jpeg, png or gif file found in the directory as the album art.

Pay attention to case sensitivity when defining `music_dir`.

`settings` can use `mpd_now` table, which contains the following values:

(**note:** the first four are boolean [flags](https://github.com/lcpz/lain/pull/205), the remaining are all strings)

- random_mode
- single_mode
- repeat_mode
- consume_mode
- pls_pos (playlist position)
- pls_len (playlist length)
- state (possible values: "play", "pause", "stop")
- file
- artist
- title
- name
- album
- track
- genre
- date
- [time](https://github.com/lcpz/lain/pull/90) (length of current song, in seconds)
- [elapsed](https://github.com/lcpz/lain/pull/90) (elapsed time of current song, in seconds)

and can modify `mpd_notification_preset` table, which will be the preset for the naughty notifications. Check [here](https://awesomewm.org/doc/api/libraries/naughty.html#notify) for the list of variables it can contain. Default definition:

```lua
mpd_notification_preset = {
   title   = "Now playing",
   timeout = 6,
   text    = string.format("%s (%s) - %s\n%s", mpd_now.artist,
             mpd_now.album, mpd_now.date, mpd_now.title)
}
```

With multiple screens, the default behaviour is to show a visual notification pop-up window on the first screen. By setting `followtag` to `true` it will be shown on the currently focused tag screen.

## Output table

Variable | Meaning | Type
--- | --- | ---
`widget` | The textbox | `wibox.widget.textbox`
`update` | Update `widget` | function
`timer` | The widget timer | [`gears.timer`](https://awesomewm.org/doc/api/classes/gears.timer.html)

The `update` function can be used to refresh the widget before `timeout` expires.

You can use `timer` to start/stop the widget as you like.

## Keybindings

You can control the widget with keybindings like these:

```lua
-- MPD control
awful.key({ altkey, "Control" }, "Up",
	function ()
		awful.spawn.with_shell("mpc toggle || ncmpc toggle || pms toggle")
		mympd.update()
	end),
awful.key({ altkey, "Control" }, "Down",
	function ()
		awful.spawn.with_shell("mpc stop || ncmpc stop || pms stop")
		mympd.update()
	end),
awful.key({ altkey, "Control" }, "Left",
	function ()
		awful.spawn.with_shell("mpc prev || ncmpc prev || pms prev")
		mympd.update()
	end),
awful.key({ altkey, "Control" }, "Right",
	function ()
		awful.spawn.with_shell("mpc next || ncmpc next || pms next")
		mympd.update()
	end),
```

where `altkey = "Mod1"`.

If you don't use the widget for long periods and wish to spare CPU, you can toggle it with a keybinding like this:

```lua
-- disable MPD widget
awful.key({ altkey }, "0",
    function ()
        local common = {
            text = "MPD widget ",
            position = "top_middle",
            timeout = 2
        }
        if mympd.timer.started then
            mympd.timer:stop()
            common.text = common.text .. markup.bold("OFF")
        else
            mympd.timer:start()
            common.text = common.text .. markup.bold("ON")
        end
        naughty.notify(common)
    end),
```

## Notes

### Cover not showing in notifications

If the cover file is existent but not showed in notifications, [try](https://github.com/lcpz/lain/issues/393) setting `music_dir` to a symlink of your music folder, rather than to a physical path. This can be easily done through
```shell
ln -s /the/real_path_to_your_music/ /home/username/Music
```
However, this only applies if the music is stored outside your user-specific folder, for instance in an external partition.

### Always use `set_markup`

In `settings`, if you use `widget:set_text`, [it will ignore Pango markup](https://github.com/lcpz/lain/issues/258), so be sure to always use `widget:set_markup`.

### Volume fade in toggling MPD

If you want a fade in/out in toggling MPD, you can put [this script](https://gist.github.com/lcpz/76e315bc27c6cdf7edd5021964b88df1) in your local `bin` directory:

```shell
$ curl https://gist.githubusercontent.com/lcpz/76e315bc27c6cdf7edd5021964b88df1/raw/97f7ba586418a4e07637cfbc91d2974278dfa623/mpd-fade -o ~/bin/mpc-fade
$ chmod +x ~/bin/mpc-fade
```

Set your 1% decrease/increase commands [here](https://gist.github.com/lcpz/76e315bc27c6cdf7edd5021964b88df1#file-mpd-fade-L8-L9), then use a keybinding like this:

```lua
-- MPD toggle with volume fading
awful.key({ "Shift" }, "Pause",
    function()
        awful.spawn.easy_async("mpc-fade 20 4", -- mpc-fade <percentage> <length in secs>
        function(stdout, stderr, reason, exit_code)
            mympd.update()
        end)
    end),
```
