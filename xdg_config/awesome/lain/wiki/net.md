## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Monitors network interfaces and shows current traffic.

```lua
local mynet = lain.widget.net()
```

## Input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout (in seconds) | integer | 2
`iface` | Network device(s) | string (single interface) or table of strings (multiple interfaces) | autodetected
`units` | Units | integer | 1024 (kilobytes)
`notify` | Display "no carrier" notifications | string | "on"
`wifi_state` | Get Wi-Fi connection status | string | "off"
`eth_state` | Get Ethernet connection status | string | "off"
`screen` | Notifications screen | integer | 1
`settings` | User settings | function | empty function

`iface` can be a string or an table of the form `{ "eth0", "eth1", ... }` containing a list of the devices to collect data on.

If more than one device is included, `net_now.sent` and `net_now.received` will contain cumulative values over all given devices.
Use `net_now.devices["eth0"]` to access `sent`, `received`, `state` or `carrier` per device.

Possible alternative values for `units` are 1 (byte) or multiple of 1024: 1024^2 (MB), 1024^3 (GB), and so on.

If `notify = "off"` is set, the widget won't display a notification when there's no carrier.

`settings` can use the following `iface` related strings:

- `net_now.carrier` ("0", "1");
- `net_now.state` ("up", "down");
- `net_now.sent` and `net_now.received` (numbers) will be the sum across all specified interfaces;
- `net_now.devices["interface"]` contains the previous attributes for each detected interface.

If `wifi_state = "on"` is set, `settings` can use the following extra strings attached to `net_now.devices["wireless interface"]`:
- `wifi` (true, false) indicates if the interface is connected to a network;
- `signal` (number) is the connection signal strength in dBm;

If `eth_state = "on"` is set, `settings` can use the following extra string: `net_now.devices["ethernet interface"].ethernet`, which is a boolean indicating if an Ethernet connection's active.

For compatibility reasons, if multiple devices are given, `net_now.carrier` and `net_now.state` correspond to the last interface in the `iface` table and should not be relied upon (deprecated).

## Output table

Variable | Meaning | Type
--- | --- | ---
`widget` | The widget | `wibox.widget.textbox`
`update` | Update `widget` | function
`get_devices` | Update the `iface` table | function

## Notes

### Setting `iface` manually

If the widget [spawns a "no carrier" notification and you are sure to have an active network device](https://github.com/lcpz/lain/issues/102), then autodetection is probably not working. This may due to [your user privileges](https://github.com/lcpz/lain/issues/102#issuecomment-246470526). In this case you can set `iface` manually. You can see which device is **UP,LOWER_UP** with the following command:

```shell
ip link show
```
## Usage examples
### Two widgets for upload/download rates from the same `iface`

```lua
local mynetdown = wibox.widget.textbox()
local mynetup = lain.widget.net {
    settings = function()
        widget:set_markup(net_now.sent)
        mynetdown:set_markup(net_now.received)
    end
}
```
### Wi-Fi/Ethernet connection and signal strength indicator
```lua
local wifi_icon = wibox.widget.imagebox()
local eth_icon = wibox.widget.imagebox()
local net = lain.widget.net {
    notify = "off",
    wifi_state = "on",
    eth_state = "on",
    settings = function()
        local eth0 = net_now.devices.eth0
        if eth0 then
            if eth0.ethernet then
                eth_icon:set_image(ethernet_icon_filename)
            else
                eth_icon:set_image()
            end
        end

        local wlan0 = net_now.devices.wlan0
        if wlan0 then
            if wlan0.wifi then
                local signal = wlan0.signal
                if signal < -83 then
                    wifi_icon:set_image(wifi_weak_filename)
                elseif signal < -70 then
                    wifi_icon:set_image(wifi_mid_filename)
                elseif signal < -53 then
                    wifi_icon:set_image(wifi_good_filename)
                elseif signal >= -53 then
                    wifi_icon:set_image(wifi_great_filename)
                end
            else
                wifi_icon:set_image()
            end
        end
    end
}
```