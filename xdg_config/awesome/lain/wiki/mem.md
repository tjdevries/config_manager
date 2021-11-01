## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Shows memory status in MiB, [like `top` and `free -h`](https://github.com/lcpz/lain/issues/271).

```lua
local mymem = lain.widget.mem()
```

## Input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout (in seconds) | integer | 2
`settings` | User settings | function | empty function
`widget` | Widget to render | function | `wibox.widget.textbox`

in `settings` you can use the following variables:

Variable | Meaning | Type
--- | --- | ---
`mem_now.used` | Memory used (MiB) | string
`mem_now.swapused` | Swap memory used (MiB) | string
`mem_now.perc` | Memory percentage | int

(See line 23-39 of [this file](https://github.com/lcpz/lain/blob/master/widget/mem.lua) for more potential variables.)

## Output table

Variable | Meaning | Type
--- | --- | ---
`widget` | The widget | `wibox.widget.textbox`
`update` | Update `widget` | function