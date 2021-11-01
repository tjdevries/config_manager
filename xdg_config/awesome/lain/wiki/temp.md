## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Shows the current CPU temperature.

```lua
local mytemp = lain.widget.temp()
```

## Input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout (in seconds) | integer | 30
`tempfile` | Path of file which stores core temperature value | string | "/sys/devices/virtual/thermal/thermal_zone0/temp"
`settings` | User settings | function | empty function
`widget` | Widget to render | function | `wibox.widget.textbox`

`settings` can use the string `coretemp_now`, which contains the info retrieved from `tempfile`, and the table `temp_now`, which contains an entry for each `*temp*` file in each directory in the following paths:

```shell
/sys/class/devices/virtual/thermal/thermal_zone*
/sys/class/devices/platform/coretemp*/hwmon/hwon*
```

All values are expressed in Celsius (GNU/Linux standard).

## Output table

Variable | Meaning | Type
--- | --- | ---
`widget` | The widget | `wibox.widget.textbox`
`update` | Update `widget` | function
