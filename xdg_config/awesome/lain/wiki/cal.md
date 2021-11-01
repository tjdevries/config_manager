## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Creates a calendar notification that can be attached to widgets.

This is a simpler but [faster](https://github.com/awesomeWM/awesome/issues/1861)
alternative to [`awful.widget.calendar_popup`](https://awesomewm.org/doc/api/classes/awful.widget.calendar_popup.html), which emulates UNIX's `cal`.

```lua
local mycal = lain.widget.cal()
```

## Input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`attach_to` | List of widgets | table | empty table
`week_start` | First day of the week | integer | 2 (Monday)
`three` | Display three months spanning the date | boolean | false
`followtag` | Display the notification on currently focused screen | boolean | false
`week_number` | Display the week number | string ("none", "left" or "right") | "none"
`week_number_format` | Week number format | string | `"%3d \| "` for "left", `"\| %-3d"` for "right"
`icons` | Path to calendar icons | string | [icons/cal/white/](https://github.com/lcpz/lain/tree/master/icons/cal/white)
`notification_preset` | Notification preset | table | See [default `notification_preset`](https://github.com/lcpz/lain/wiki/cal#default-notification_preset)

Set `attach_to` as the list of widgets to which you want to attach the calendar, like this:

```lua
local mycal = lain.widget.cal {
    attach_to = { mywidget1, mywidget2, ...  },
    -- [...]
}
```

For every widget in `attach_to`:

- Left click / scroll down: switch to previous month.
- Middle click show current month.
- Right click / scroll up: switch to next month.

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
`attach` | Attach the calendar to an input widget | function
`show` | Show calendar | function
`hide` | Hide calendar | function

`attach` takes as argument any widget you want to attach the calendar to, while
`show` takes as optional argument an integer to indicate the seconds to timeout.

## Keybinding

```lua
awful.key({ altkey }, "c", function () mycal.show(7) end)
```

Where `altkey = "Mod1"`.

## Notes

* Naughty notifications require `notification_preset.font` to be **monospaced**, in order to correctly display the output.
* If you want to [disable notification icon](https://github.com/lcpz/lain/pull/351), set `icons = ""` in the input table.
* If you want to localise the calendar, put `os.setlocale(os.getenv("LANG"))` in your `rc.lua`.
* If you want to get notifications [only with mouse clicks](https://github.com/lcpz/lain/issues/320) on a given widget, use this code:
  ```lua
  yourwidget:disconnect_signal("mouse::enter", mycal.hover_on)
  ```
