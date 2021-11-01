Welcome to the Lain wiki!

If you spot a typo or have a suggestion to improve these pages, please notify me opening an [issue](https://github.com/lcpz/lain/issues) format. Thank you.

Dependencies
------------

Package | Requested by | Reasons of choice
--- | --- | ---
[curl](https://curl.haxx.se) | `imap`, `mpd`, and `weather` widgets | 1. faster and simpler to use than [LuaSocket](https://github.com/diegonehab/luasocket); 2. it's in the core of almost every distro; 3. can be called [asynchronously](https://awesomewm.org/doc/api/libraries/awful.spawn.html#easy_async)
GLib >= 2.54 | `fs` widget | Pure Awesome/Lua implementation.

The second dependency will be removed once all major distros update their Gio/Glib versions.

Installation
------------

### Arch Linux

[AUR package](https://aur.archlinux.org/packages/lain-git/)

### Other distributions

```shell
git clone https://github.com/lcpz/lain.git ~/.config/awesome/lain
```

Also available via [LuaRocks](https://luarocks.org/modules/aajjbb/lain).

Usage
--------

First, include it into your `rc.lua`:

```lua
local lain = require("lain")
```

Then check out the submodules you want:

- [Layouts](https://github.com/lcpz/lain/wiki/Layouts)
- [Widgets](https://github.com/lcpz/lain/wiki/Widgets)
- [Utilities](https://github.com/lcpz/lain/wiki/Utilities)
