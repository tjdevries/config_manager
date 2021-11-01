## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Shows the current system load.

```lua
mysysload = lain.widget.sysload()
```

## Input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout (in seconds) | integer | 2
`settings` | User settings | function | empty function
`widget` | Widget to render | function | `wibox.widget.textbox`

`settings` can use strings `load_1`, `load_5` and `load_15`, which are the load averages over 1, 5, and 15 minutes.

## Output table

Variable | Meaning | Type
--- | --- | ---
`widget` | The widget | `wibox.widget.textbox`
`update` | Update `widget` | function