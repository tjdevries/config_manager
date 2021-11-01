# Description

[`tp_smapi`](http://www.thinkwiki.org/wiki/Tp_smapi) interface and widget creator.

```lua
local tp_smapi = lain.widget.contrib.tp_smapi(apipath)
```

The argument `apipath` is an optional string which defines the API path. Its default value is `"/sys/devices/platform/smapi"`.

# Functions

## tp_smapi.get(batid, feature)

Gets the `feature` of battery `batid`. Returns a string. The list of available features is available at [this page](https://www.thinkwiki.org/wiki/Tp_smapi#Battery_status_features).

## tp_smapi.installed(batid)

Checks if battery `batid` is installed. Returns a boolean.

## tp_smapi.status(batid)

Gets the status of battery `batid`. Returns a string ("charging", "discharging", or "full").

## tp_smapi.percentage(batid)

Gets the percentage of battery `batid`. Returns a numeric string.

## tp_smapi.time(batid)

Gets the time of battery `batid`. Depending on the current status, it can be either running or charging time. Returns a string of the format `HH:MM`.

## tp_smapi.hide()

Removes any notification spawned by `tp_smapi.show`.

## tp_smapi.show(batid, seconds, scr)

Notifies the current information of battery `batid` for `seconds` seconds on screen `scr`.
The argument `scr` is optional, and if missing, the notification will be displayed on the currently focused screen.

## tp_smapi.create_widget(args)

Creates a [lain widget](https://github.com/lcpz/lain/wiki/Widgets#usage) of the available ThinkPad batteries.

```lua
local tpbat = tp_smapi.create_widget()
```

### Input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`widget` | The widget type to use | [`wibox.widget`](https://awesomewm.org/doc/api/classes/wibox.widget.html) | [`wibox.widget.textbox`](https://awesomewm.org/doc/api/classes/wibox.widget.textbox.html)
`timeout` | Refresh timeout (in seconds) | integer | 30
`pspath` | Power supply directory path | string | "/sys/class/power_supply/"
`battery` | Single battery id | string | autodetected
`batteries` | Multiple batteries id table | table of strings | autodetected
`settings` | User settings | function | empty function
`widget` | Widget to render | function | `wibox.widget.textbox`

The widget will try to autodetect `battery` and `batteries`. If something
goes wrong, you will have to define them manually. In that case, you only have
to define one between `battery` and `batteries`. If you have one battery, you
can either use `args.battery = "BAT*"` or `args.batteries = {"BAT*"}`, where `BAT*`
is the identifier of your battery in `pspath` (do not use it as a wildcard).
Of course, if you have multiple batteries, you need to use the latter option.

If you define `pspath`, **be sure** to not forget the final slash (/).

`settings` can use the `tpbat_now` table, which contains the following strings:

- `status`, general status ("N/A", "discharging", "charging", "full");
- `n_status[i]`, i-th battery status (like above);
- `n_perc[i]`, i-th battery charge percentage (like above);
- `n_time[i]`, i-th battery running or charging time (HH:MM string or "N/A");

`n_time[i]` is the running time of battery `i` when it is discharging, and the charging time otherwise.

### Output table

Variable | Meaning | Type
--- | --- | ---
`widget` | The widget | [`wibox.widget`](https://awesomewm.org/doc/api/classes/wibox.widget.html) | [textbox](https://awesomewm.org/doc/api/classes/wibox.widget.textbox.html)
`batteries` | Battery identifiers | Table of strings
`update` | Update `widget` | function
`timer` | The widget timer | [`gears.timer`](https://awesomewm.org/doc/api/classes/gears.timer.html)

The `update` function can be used to refresh the widget before `timeout` expires.

### Usage example

```lua
local tp_smapi = lain.widget.contrib.tp_smapi()
local bat = tp_smapi.create_widget {
  battery  = "BAT0",
  settings = function()
    widget:set_markup(tpbat_now.n_perc[1] .. "%")
  end
}

bat.widget:connect_signal("mouse::enter", function () tp_smapi.show("BAT0") end)
bat.widget:connect_signal("mouse::leave", function () tp_smapi.hide() end)
```
