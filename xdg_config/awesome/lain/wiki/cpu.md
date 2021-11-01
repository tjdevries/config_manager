## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Shows the current CPU usage, both in general and per core.

```lua
local mycpu = lain.widget.cpu()
```

## Input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout (in seconds) | integer | 2
`settings` | User settings | function | empty function
`widget` | Widget to render | function | `wibox.widget.textbox`

`settings` can use these strings:

* `cpu_now.usage`, the general use percentage;
* `cpu_now[i].usage`, the i-th core use percentage, with `i` starting from 1.

## Output table

Variable | Meaning | Type
--- | --- | ---
`widget` | The widget | `wibox.widget.textbox`
`update` | Update `widget` | function