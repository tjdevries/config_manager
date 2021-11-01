## Usage

[Read here.](https://github.com/lcpz/lain/wiki/Widgets#usage)

### Description

Shows mails count fetching over IMAP.

```lua
local myimap = lain.widget.imap(args)
```

New mails are notified like this:

	+--------------------------------------------+
	| +---+                                      |
	| |\ /| donald@disney.org has 3 new messages |
	| +---+                                      |
	+--------------------------------------------+

## Input table

Required parameters are:

Variable | Meaning | Type
--- | --- | ---
`server` | Mail server | string
`mail` | User mail | string
`password` | User password | string
`widget` | Widget to render | function | `wibox.widget.textbox`

while the optional are:

Variable | Meaning | Type | Default
--- | --- | --- | ---
`port` | IMAP port | integer | 993
`timeout` | Refresh timeout (in seconds) | integer | 60
`pwdtimeout` | Timeout for password retrieval function (see [here](https://github.com/lcpz/lain/wiki/imap#password-security)) | integer | 10
`is_plain` | Define whether `password` is a plain password (true) or a command that retrieves it (false) | boolean | false
`followtag` | Notification behaviour | boolean | false
`notify` | Show notification popups | string | "on"
`settings` | User settings | function | empty function

`settings` can use `imap_now` table, which contains the following non negative integers:

- `["MESSAGES"]`
- `["RECENT"]`
- `["UNSEEN"]`

example of fetch: `total = imap_now["MESSAGES"]`. For backwards compatibility, `settings` can also use `mailcount`, a pointer to `imap_now["UNSEEN"]`.

Also, `settings` can modify `mail_notification_preset` table, which will be the preset for the naughty notifications. Check [here](https://awesomewm.org/apidoc/libraries/naughty.html#notify) for the list of variables it can contain. Default definition:

```lua
mail_notification _preset = {
    icon = "lain/icons/mail.png",
    position = "top_left"
}
```

Note that `mailcount` and `imap_now` elements are equals to 0 either if there are no new mails or credentials are invalid, so make sure that your settings are correct.

With multiple screens, the default behaviour is to show a visual notification pop-up window on the first screen. By setting `followtag` to `true` it will be shown on the currently focused tag screen.

You can have multiple instances of this widget at the same time.

## Password security

The reason why `is_plain` is false by default is to discourage the habit of storing passwords in plain.

In general, when `is_plain == false`, `password` can be either a string, a table or a function: the widget will execute it asynchronously in the first two cases.

### Using plain passwords

You can set your password in plain like this:

```lua
myimapcheck = lain.widget.imap {
    is_plain = true,
    password = "mymailpassword",
    -- [...]
}
```

and you will have the same security provided by `~/.netrc`.

### Using a password manager

I recommend to use [spm](https://notabug.org/kl3/spm) or [pass](https://www.passwordstore.org). In this case, `password` has to be a function. Example stub:

```lua
myimapcheck = lain.widget.imap {
    password = function()
        -- do your retrieval
        return retrieved_password, try_again
    end,
    -- [...]
}
```

Where `retrieved_password` is the password retrieved from the manager, and `try_again` supports [DBus Secret Service](https://specifications.freedesktop.org/secret-service).

The process flow is that the first `password()` call spawns the unlock prompt, then the second call retrieves the password. [Here](https://gist.github.com/lcpz/1854fc4320f4701957cd5309c8eed4a6) is an example of `password` function.

## Output table

Variable | Meaning | Type
--- | --- | ---
`widget` | The widget | `wibox.widget.textbox`
`update` | Update `widget` | function
`timer` | The widget timer | [`gears.timer`](https://awesomewm.org/doc/api/classes/gears.timer.html)
`pwdtimer` | Password retrieval timer (available only if `password` is a function)| [`gears.timer`](https://awesomewm.org/doc/api/classes/gears.timer.html)

The `update` function can be used to refresh the widget before `timeout` expires.

You can use `timer` to start/stop the widget as you like.
