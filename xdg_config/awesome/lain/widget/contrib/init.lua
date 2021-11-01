--[[

     Lain
     Layouts, widgets and utilities for Awesome WM

     Users contributed widgets section

     Licensed under GNU General Public License v2
      * (c) 2013, Luca CPZ

--]]

local wrequire     = require("lain.helpers").wrequire
local setmetatable = setmetatable

local widget = { _NAME = "lain.widget.contrib" }

return setmetatable(widget, { __index = wrequire })
