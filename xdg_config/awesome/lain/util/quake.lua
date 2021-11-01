--[[

     Licensed under GNU General Public License v2
      * (c) 2016, Luca CPZ
      * (c) 2015, unknown

--]]

local awful        = require("awful")
local capi         = { client = client }
local math         = math
local string       = string
local pairs        = pairs
local screen       = screen
local setmetatable = setmetatable

-- Quake-like Dropdown application spawn
local quake = {}

-- If you have a rule like "awful.client.setslave" for your terminals,
-- ensure you use an exception for QuakeDD. Otherwise, you may
-- run into problems with focus.

function quake:display()
    if self.followtag then self.screen = awful.screen.focused() end

    -- First, we locate the client
    local client = nil
    local i = 0
    for c in awful.client.iterate(function (c)
        -- c.name may be changed!
        return c.instance == self.name
    end)
    do
        i = i + 1
        if i == 1 then
            client = c
        else
            -- Additional matching clients, let's remove the sticky bit
            -- which may persist between awesome restarts. We don't close
            -- them as they may be valuable. They will just turn into
            -- normal clients.
            c.sticky = false
            c.ontop = false
            c.above = false
        end
    end

    if not client and not self.visible then return end

    if not client then
        -- The client does not exist, we spawn it
        local cmd = string.format("%s %s %s", self.app,
              string.format(self.argname, self.name), self.extra)
        awful.spawn(cmd, { tag = self.screen.selected_tag })
        return
    end

    -- Set geometry
    client.floating = true
    client.border_width = self.border
    client.size_hints_honor = false
    local maximized = client.maximized
    local fullscreen = client.fullscreen
    client:geometry(self.geometry[self.screen.index] or self:compute_size())

    -- Set not sticky and on top
    client.sticky = false
    client.ontop = true
    client.above = true
    client.skip_taskbar = true

    -- Additional user settings
    if self.settings then self.settings(client) end

    -- Toggle display
    if self.visible then
        client.hidden = false
        client.maximized = self.maximized
        client.fullscreen = self.fullscreen
        client:raise()
        self.last_tag = self.screen.selected_tag
        client:tags({self.screen.selected_tag})
        capi.client.focus = client
    else
        self.maximized = maximized
        self.fullscreen = fullscreen
        client.maximized = false
        client.fullscreen = false
        client.hidden = true
        local ctags = client:tags()
        for j, _ in pairs(ctags) do
            ctags[j] = nil
        end
        client:tags(ctags)
    end

    return client
end

function quake:compute_size()
    -- skip if we already have a geometry for this screen
    if not self.geometry[self.screen.index] then
        local geom
        if not self.overlap then
            geom = screen[self.screen.index].workarea
        else
            geom = screen[self.screen.index].geometry
        end
        local width, height = self.width, self.height
        if width  <= 1 then width = math.floor(geom.width * width) - 2 * self.border end
        if height <= 1 then height = math.floor(geom.height * height) end
        local x, y
        if     self.horiz == "left"  then x = geom.x
        elseif self.horiz == "right" then x = geom.width + geom.x - width
        else   x = geom.x + (geom.width - width)/2 end
        if     self.vert == "top"    then y = geom.y
        elseif self.vert == "bottom" then y = geom.height + geom.y - height
        else   y = geom.y + (geom.height - height)/2 end
        self.geometry[self.screen.index] = { x = x, y = y, width = width, height = height }
    end
    return self.geometry[self.screen.index]
end

function quake:toggle()
     if self.followtag then self.screen = awful.screen.focused() end
     local current_tag = self.screen.selected_tag
     if current_tag and self.last_tag ~= current_tag and self.visible then
         local c=self:display()
         if c then
            c:move_to_tag(current_tag)
        end
     else
         self.visible = not self.visible
         self:display()
     end
end

function quake.new(conf)
    conf = conf or {}

    conf.app        = conf.app       or "xterm"    -- application to spawn
    conf.name       = conf.name      or "QuakeDD"  -- window name
    conf.argname    = conf.argname   or "-name %s" -- how to specify window name
    conf.extra      = conf.extra     or ""         -- extra arguments
    conf.border     = conf.border    or 1          -- client border width
    conf.visible    = conf.visible   or false      -- initially not visible
    conf.followtag  = conf.followtag or false      -- spawn on currently focused screen
    conf.overlap    = conf.overlap   or false      -- overlap wibox
    conf.screen     = conf.screen    or awful.screen.focused()
    conf.settings   = conf.settings

    -- If width or height <= 1 this is a proportion of the workspace
    conf.height     = conf.height    or 0.25       -- height
    conf.width      = conf.width     or 1          -- width
    conf.vert       = conf.vert      or "top"      -- top, bottom or center
    conf.horiz      = conf.horiz     or "left"     -- left, right or center
    conf.geometry   = {}                           -- internal use

    conf.maximized = false
    conf.fullscreen = false

    local dropdown = setmetatable(conf, { __index = quake })

    capi.client.connect_signal("manage", function(c)
        if c.instance == dropdown.name and c.screen == dropdown.screen then
            dropdown:display()
        end
    end)
    capi.client.connect_signal("unmanage", function(c)
        if c.instance == dropdown.name and c.screen == dropdown.screen then
            dropdown.visible = false
        end
     end)

    return dropdown
end

return setmetatable(quake, { __call = function(_, ...) return quake.new(...) end })
