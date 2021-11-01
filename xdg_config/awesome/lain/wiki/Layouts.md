
    lain/layout
    .
    |-- termfair
    |-- termfair.center
    |-- cascade
    |-- cascade.tile
    |-- centerwork
    |-- centerwork.horizontal

Usage
=====

As usual, specify your favourites in `awful.layout.layouts`, or set them on specific tags with [`awful.layout.set`](https://awesomewm.org/doc/api/libraries/awful.layout.html#set).

```lua
awful.layout.set(lain.layout.termfair, tag)
```

How do layouts work?
====================

`termfair`
--------

This layout restricts the size of each window. Each window will have the
same width but is variable in height. Furthermore, windows are
left-aligned. The basic workflow is as follows (the number above the
screen is the number of open windows, the number in a cell is the fixed
number of a client):

	     (1)                (2)                (3)
	+---+---+---+      +---+---+---+      +---+---+---+
	|   |   |   |      |   |   |   |      |   |   |   |
	| 1 |   |   |  ->  | 2 | 1 |   |  ->  | 3 | 2 | 1 |  ->
	|   |   |   |      |   |   |   |      |   |   |   |
	+---+---+---+      +---+---+---+      +---+---+---+

	     (4)                (5)                (6)
	+---+---+---+      +---+---+---+      +---+---+---+
	| 4 |   |   |      | 5 | 4 |   |      | 6 | 5 | 4 |
	+---+---+---+  ->  +---+---+---+  ->  +---+---+---+
	| 3 | 2 | 1 |      | 3 | 2 | 1 |      | 3 | 2 | 1 |
	+---+---+---+      +---+---+---+      +---+---+---+

The first client will be located in the left column. When opening
another window, this new window will be placed in the left column while
moving the first window into the middle column. Once a row is full,
another row above it will be created.

Default number of columns and rows are respectively taken from `nmaster`
and `ncol` values in `awful.tag`, but you can set your own.

For example, this sets `termfair` to 3 columns and at least 1 row:

```lua
lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol    = 1
```

`termfair.center`
----------

Similar to `termfair`, but with fixed number of vertical columns. Cols are centerded until there are `nmaster` columns, then windows are stacked as slaves, with possibly `ncol` clients per column at most.

            (1)                (2)                (3)
       +---+---+---+      +-+---+---+-+      +---+---+---+
       |   |   |   |      | |   |   | |      |   |   |   |
       |   | 1 |   |  ->  | | 1 | 2 | | ->   | 1 | 2 | 3 |  ->
       |   |   |   |      | |   |   | |      |   |   |   |
       +---+---+---+      +-+---+---+-+      +---+---+---+

            (4)                (5)
       +---+---+---+      +---+---+---+
       |   |   | 3 |      |   | 2 | 4 |
       + 1 + 2 +---+  ->  + 1 +---+---+
       |   |   | 4 |      |   | 3 | 5 |
       +---+---+---+      +---+---+---+

Like `termfair`, default number of columns and rows are respectively taken from `nmaster`
and `ncol` values in `awful.tag`, but you can set your own.

For example, this sets `termfair.center` to 3 columns and at least 1 row:

```lua
lain.layout.termfair.center.nmaster = 3
lain.layout.termfair.center.ncol    = 1
```

`cascade`
-------

Cascade all windows of a tag.

You can control the offsets by setting these two variables:

```lua
lain.layout.cascade.offset_x = 64
lain.layout.cascade.offset_y = 16
```

The following reserves space for 5 windows:

```lua
lain.layout.cascade.nmaster = 5
```

That is, no window will get resized upon the creation of a new window,
unless there's more than 5 windows.

`cascade.tile`
-----------

Similar to `awful.layout.suit.tile` layout, however, clients in the slave
column are cascaded instead of tiled.

Left column size can be set, otherwise is controlled by `mwfact` of the
tag. Additional windows will be opened in another column on the right.
New windows are placed above old windows.

Whether the slave column is placed on top of the master window or not is
controlled by the value of `ncol`. A value of 1 means "overlapping slave column"
and anything else means "don't overlap windows".

Usage example:

```lua
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2
```

`extra_padding` reduces the size of the master window if "overlapping
slave column" is activated. This allows you to see if there are any
windows in your slave column.

Setting `offset_x` to a very small value or even 0 is recommended to avoid wasting space.

`centerwork`
----------

You start with one window, centered horizontally:

	+--------------------------+
	|       +----------+       |
	|       |          |       |
	|       |          |       |
	|       |          |       |
	|       |   MAIN   |       |
	|       |          |       |
	|       |          |       |
	|       |          |       |
	|       |          |       |
	|       +----------+       |
	+--------------------------+

This is your main working window. You do most of the work right here.
Sometimes, you may want to open up additional windows. They're put on left and right, alternately.

	+--------------------------+
	| +---+ +----------+ +---+ |
	| |   | |          | |   | |
	| |   | |          | |   | |
	| |   | |          | |   | |
	| +---+ |   MAIN   | +---+ |
	| +---+ |          | +---+ |
	| |   | |          | |   | |
	| |   | |          | |   | |
	| |   | |          | |   | |
	| +---+ +----------+ +---+ |
	+--------------------------+

*Please note:* If you use Awesome's default configuration, navigation in
this layout may be very confusing. How do you get from the main window
to satellite ones depends on the order in which the windows are opened.
Thus, use of `awful.client.focus.bydirection()` is suggested.
Here's an example:

```lua
globalkeys = awful.util.table.join(
    -- [...]
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),
    -- [...]
)
```

`centerwork.horizontal`
-----------

Same as `centerwork`, except that the main
window expands horizontally, and the additional windows
are put ontop/below it. Useful if you have a screen turned 90°.

Pre 4.0 `uselesstile` patches
=============================

In branch 3.5, this module provided useless gaps layouts. Since useless gaps have been implemented in Awesome 4.0, those layouts have been removed.

Following are a couple of `uselesstile` variants that were not part of lain. They are kept only for reference and are not supported.

Xmonad-like
-----------

If you want to have `awful.layout.suit.tile` behave like xmonad, with internal gaps two times wider than external ones, download [this](https://gist.github.com/lcpz/9e56dcfbe66bfe14967c) as `lain/layout/uselesstile`.

Inverted master
---------------

Want to invert master window position? Use [this](https://gist.github.com/lcpz/c59dc59c9f99d98218eb) version. You can set `single_gap` with `width` and `height` in your `theme.lua`, in order to define the window geometry when there's only one client, otherwise it goes maximized. An example:

    theme.single_gap = { width = 600, height = 100 }

What about layout icons?
========================

They are located in ``lain/icons/layout``.

To use them, define new `layout_*` variables in your ``theme.lua``. For instance:

```lua
theme.lain_icons         = os.getenv("HOME") ..
                           "/.config/awesome/lain/icons/layout/default/"
theme.layout_termfair    = theme.lain_icons .. "termfair.png"
theme.layout_centerfair  = theme.lain_icons .. "centerfair.png"  -- termfair.center
theme.layout_cascade     = theme.lain_icons .. "cascade.png"
theme.layout_cascadetile = theme.lain_icons .. "cascadetile.png" -- cascade.tile
theme.layout_centerwork  = theme.lain_icons .. "centerwork.png"
theme.layout_centerworkh = theme.lain_icons .. "centerworkh.png" -- centerwork.horizontal
```

Credit goes to [Nicolas Estibals](https://github.com/nestibal) for creating
layout icons for default theme.

You can use them as a template for your custom versions.