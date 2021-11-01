## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Shows file systems informations.

If a partition is given in input, a notification will be displayed when it is almost full.

```lua
local mypartition = lain.widget.fs()
```

## Input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout (in seconds) | integer | 600
`partition` | (Optional) Partition to watch: a notification will be displayed when full | string | `nil`
`threshold` | Percentage threshold at which the notification is triggered | integer | 99
`notification_preset` | Notification preset | table | See [default `notification_preset`](https://github.com/lcpz/lain/wiki/fs#default-notification_preset)
`followtag` | Display the notification on currently focused screen | boolean | false
`showpopup` | Display popups with mouse hovering | string, possible values: "on", "off" | "on"
`settings` | User settings | function | empty function
`widget` | Widget to render | function | `wibox.widget.textbox`

`settings` can use the table `fs_now`, which contains a string entry for each file system path available. For instance, root infos are located in the variable `fs_now["/"]`. Every entry in this table have the following variables:

Variable | Meaning | Type
--- | --- | ---
`units` | (multiple of) units used | string ("Kb", "Mb", "Gb", and so on)
`percentage` | the used percentage | integer
`size` | size in `units` of the given fs | float
`used` | amount of space used in the given fs, expressed in `units` | float
`free` | amount of free space in the given fs, expressed in `units` | float

Usage example:

```lua
-- shows used (percentage) and remaining space in home partition
local fsroothome = lain.widget.fs({
    settings  = function()
        widget:set_text("/home: " ..  fs_now["/home"].percentage .. "% (" ..
        fs_now["/home"].free .. " " .. fs_now["/home"].units .. " left)")
    end
})
-- output example: "/home: 37% (239.4 Gb left)"
```

With multiple screens, the default behaviour is to show a visual notification pop-up window on the first screen. By setting `followtag` to `true` it will be shown on the currently focused tag screen.

### Default `notification_preset`

```lua
notification_preset = {
    font = "Monospace 10",
    fg   = "#FFFFFF",
    bg   = "#000000"
}
```

## Output table

Variable | Meaning | Type
--- | --- | ---
`widget` | The widget | `wibox.widget.textbox`
`show` | The notification | function

You can display the notification with a key binding like this:

```lua
awful.key({ altkey }, "h", function () mypartition.show(seconds, scr) end),
```

where ``altkey = "Mod1"`` and ``show`` arguments, both optionals, are:

* `seconds`, notification time in seconds
* `scr`, screen which to display the notification in

## Note

Naughty notifications require `notification_preset.font` to be **monospaced**, in order to correctly display the output.
