## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Shows the remaining time and percentage capacity of your laptop battery, as well
as the current wattage. Multiple batteries are supported.

Displays a notification when battery is fully charged, low, or critical.

```lua
local mybattery = lain.widget.bat()
```

## Input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout (in seconds) | integer | 30
`pspath` | Power supply directory path | string | "/sys/class/power_supply/"
`battery` | Single battery id | string | autodetected
`batteries` | Multiple batteries id table | table of strings | autodetected
`ac` | AC | string | autodetected
`notify` | Show notification popups | string | "on"
`full_notify` | Show a notification popup when the battery's fully charged | string | inherited value from `notify`
`n_perc` | Percentages assumed for critical and low battery levels | table of integers | `{5, 15}`
`settings` | User settings | function | empty function
`widget` | Widget to render | function | `wibox.widget.textbox`

The widget will try to autodetect `battery`, `batteries` and `ac`. If something
goes wrong, you will have to define them manually. In that case, you only have
to define one between `battery` and `batteries`. If you have one battery, you
can either use `args.battery = "BAT*"` or `args.batteries = {"BAT*"}`, where `BAT*`
is the identifier of your battery in `pspath` (do not use it as a wildcard).
Of course, if you have multiple batteries, you need to use the latter option.

To disable notifications, set `notify` to `"off"`.

If you define `pspath`, **be sure** to not forget the final slash (/).

`settings` can use the `bat_now` table, which contains the following strings:

- `status`, general status ("N/A", "Discharging", "Charging", "Full");
- `n_status[i]`, i-th battery status (like above);
- `ac_status`, AC-plug flag (0 if cable is unplugged, 1 if plugged, "N/A" otherwise);
- `perc`, total charge percentage (integer between 0 and 100 or "N/A");
- `n_perc[i]`, i-th battery charge percentage (like above);
- `time`, time remaining until charge if charging, until discharge if discharging (HH:MM string or "N/A");
- `watt`, battery watts (float with 2 decimals).

and can modify the following three tables, which will be the preset for the naughty notifications:
* `bat_notification_charged_preset` (used if battery is fully charged and connected to AC)
* `bat_notification_low_preset` (used if battery charge level <= 15)
* `bat_notification_critical_preset` (used if battery charge level <= 5)

Check [here](https://awesomewm.org/doc/api/libraries/naughty.html#notify) for
the list of variables they can contain. Default definitions:

```lua
bat_notification_charged_preset = {
        title   = "Battery full",
        text    = "You can unplug the cable",
        timeout = 15,
        fg      = "#202020",
        bg      = "#CDCDCD"
    }

```

```lua
bat_notification_low_preset = {
        title = "Battery low",
        text = "Plug the cable!",
        timeout = 15,
        fg = "#202020",
        bg = "#CDCDCD"
}
```
```lua
bat_notification_critical_preset = {
        title = "Battery exhausted",
        text = "Shutdown imminent",
        timeout = 15,
        fg = "#000000",
        bg = "#FFFFFF"
}
```

## Output table

Variable | Meaning | Type
--- | --- | ---
`widget` | The widget | `wibox.widget.textbox`
`update` | Update `widget` | function

The `update` function can be used to refresh the widget before `timeout` expires.

## Note

Alternatively, you can try the [`upower` recipe](https://awesomewm.org/recipes/watch).
