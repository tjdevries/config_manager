## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Attaches a [taskwarrior](http://taskwarrior.org) notifications to a widget, and lets you execute `task` commands from the promptbox.

```lua
lain.widget.contrib.task.attach(widget, args)
```

`args` is an optional table which can contain:

Variable | Meaning | Type | Default
--- | --- | --- | ---
`show_cmd` | Taskwarrior command to show in the popup | string | "task next"
`prompt_text` | Prompt text | string | "Enter task command: "
`followtag` | Display the notification on currently focused screen | boolean | false
`notification_preset` | Notification preset | table | See [default `notification_preset`](https://github.com/lcpz/lain/wiki/task#default-notification_preset)

The tasks are shown in a notification popup when the mouse is moved over the attached `widget`, and the popup is hidden when the mouse is moved away. By default, the notification will show the output of `task next`. With `show_cmd`, the `task` popup command can be customized, for example if you want to [filter the tasks](https://taskwarrior.org/docs/filter.html) or show a [custom report](https://github.com/lcpz/lain/pull/213).

With multiple screens, the default behaviour is to show a visual notification pop-up window on the first screen. By setting `followtag` to `true` it will be shown on the currently focused tag screen.

You can call the notification with a keybinding like this:

```lua
awful.key({ modkey, altkey }, "t", function () lain.widget.contrib.task.show(scr) end),
```

where ``altkey = "Mod1"`` and `scr` (optional) indicates the screen which you want the notification in.

And you can prompt to input a `task` command with a keybinding like this:

```lua
awful.key({ altkey }, "t", lain.widget.contrib.task.prompt),
```

### Default `notification_preset`

```lua
notification_preset = {
    font = "Monospace 10",
    icon = helpers.icons_dir .. "/taskwarrior.png"
}
```

## Note

* If your widget does not display `task next` output, try changing Taskwarrior verbose, for instance: `show_cmd = 'task rc.verbose:label'` or `show_cmd = 'task rc.verbose:nothing'`.