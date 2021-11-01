### What is Redshift? #

[**Project homepage**](http://jonls.dk/redshift/)

>**Redshift** is an application that adjusts the computer display's color temperature based upon the Sun's apparent position in relation to the user's location on Earth.
>
>The program is free software, inspired by the proprietary f.lux, and can be used to reduce eye strain as well as insomnia and delayed sleep phase syndrome.
>
>The computer display's color temperature transitions evenly from night to daytime temperature to allow the user's eyes to slowly adapt. At night, the color temperature is low and is typically 3000–4000 K (default is 3500 K), preferably matching the room's lighting temperature. Typical color temperature during the daytime is 5500–6500 K (default is 5500 K).

**Source:** [Wikipedia](https://en.wikipedia.org/wiki/Redshift_%28software%29)

### Preparations

**Redshift must be installed** on your system if you want to use this widget.

Packages should be available for most distributions. Source code and build instructions can be found on Github [here](https://github.com/jonls/redshift).

You also need a valid config file. Please see the [project homepage](http://jonls.dk/redshift/) for details. An example: [`~/.config/redshift.conf`](https://github.com/jonls/redshift/blob/master/redshift.conf.sample).

You have to match the location settings to your personal situation: you can adjust the `lat` and `lon` variables using a [web service](https://encrypted.google.com/search?q=get+latitude+and+longitude).

You might also want to modify the color temperatures to fit your preferences.

### Using the widget

This widget provides the following functions:

| function | meaning |
| --- | --- |
| `redshift.toggle()` | Toggles Redshift adjustments on or off, and also restarts it if terminates. |
| `redshift.attach(widget, update_function)` | Attach to a widget. Click on the widget to toggle redshift on or off. `update_function` is a callback function which will be triggered each time Redshift changes its status. (See the examples below.) |

### Usage examples

#### Textbox status widget

```lua
myredshift = wibox.widget.textbox()
lain.widget.contrib.redshift.attach(
    myredshift,
    function (active)
        if active then
            myredshift:set_text("RS on")
        else
            myredshift:set_text("RS off")
        end
    end
)
```

Then add `myredshift` to your wibox.

#### Checkbox status widget

```lua
local markup = lain.util.markup

local myredshift = wibox.widget{
    checked      = false,
    check_color  = "#EB8F8F",
    border_color = "#EB8F8F",
    border_width = 1,
    shape        = gears.shape.square,
    widget       = wibox.widget.checkbox
}

local myredshift_text = wibox.widget{
    align  = "center",
    widget = wibox.widget.textbox,
}

local myredshift_stack = wibox.widget{
    myredshift,
    myredshift_text,
    layout = wibox.layout.stack
}

lain.widget.contrib.redshift.attach(
    myredshift,
    function (active)
        if active then
            -- rename 'beautiful' to 'theme' if using awesome-copycats
            myredshift_text:set_markup(markup(beautiful.bg_normal, "<b>R</b>"))
        else
            -- rename 'beautiful' to 'theme' if using awesome-copycats
            myredshift_text:set_markup(markup(beautiful.fg_normal, "R"))
        end
        myredshift.checked = active
    end
)
```

Then add `myredshift_stack` to your wibox.

#### Keybinding

Add this to the keybindings in your `rc.lua`:

```lua
-- Toggle Redshift with Mod+Shift+t
awful.key({ modkey, "Shift" }, "t", function () lain.widget.contrib.redshift.toggle() end),
```
