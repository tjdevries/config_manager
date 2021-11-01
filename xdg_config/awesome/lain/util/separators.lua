--[[

     Licensed under GNU General Public License v2
      * (c) 2015, Luca CPZ
      * (c) 2015, plotnikovanton

--]]

local wibox = require("wibox")
local gears = require("gears")

-- Lain Cairo separators util submodule
-- lain.util.separators
local separators = { height = 0, width = 9 }

-- [[ Arrow

-- Right
function separators.arrow_right(col1, col2)
    local widget = wibox.widget.base.make_widget()
    widget.col1 = col1
    widget.col2 = col2

    widget.fit = function(_, _, _)
        return separators.width, separators.height
    end

    widget.update = function(_, _)
        widget.col1 = col1
        widget.col2 = col2
        widget:emit_signal("widget::redraw_needed")
    end

    widget.draw = function(_, _, cr, width, height)
        if widget.col2 ~= "alpha" then
            cr:set_source_rgba(gears.color.parse_color(widget.col2))
            cr:new_path()
            cr:move_to(0, 0)
            cr:line_to(width, height/2)
            cr:line_to(width, 0)
            cr:close_path()
            cr:fill()

            cr:new_path()
            cr:move_to(0, height)
            cr:line_to(width, height/2)
            cr:line_to(width, height)
            cr:close_path()
            cr:fill()
        end

        if widget.col1 ~= "alpha" then
            cr:set_source_rgba(gears.color.parse_color(widget.col1))
            cr:new_path()
            cr:move_to(0, 0)
            cr:line_to(width, height/2)
            cr:line_to(0, height)
            cr:close_path()
            cr:fill()
        end
   end

   return widget
end

-- Left
function separators.arrow_left(col1, col2)
    local widget = wibox.widget.base.make_widget()
    widget.col1 = col1
    widget.col2 = col2

    widget.fit = function(_,  _, _)
        return separators.width, separators.height
    end

    widget.update = function(c1, c2)
        widget.col1 = c1
        widget.col2 = c2
        widget:emit_signal("widget::redraw_needed")
    end

    widget.draw = function(_, _, cr, width, height)
        if widget.col1 ~= "alpha" then
            cr:set_source_rgba(gears.color.parse_color(widget.col1))
            cr:new_path()
            cr:move_to(width, 0)
            cr:line_to(0, height/2)
            cr:line_to(0, 0)
            cr:close_path()
            cr:fill()

            cr:new_path()
            cr:move_to(width, height)
            cr:line_to(0, height/2)
            cr:line_to(0, height)
            cr:close_path()
            cr:fill()
        end

        if widget.col2 ~= "alpha" then
            cr:new_path()
            cr:move_to(width, 0)
            cr:line_to(0, height/2)
            cr:line_to(width, height)
            cr:close_path()

            cr:set_source_rgba(gears.color.parse_color(widget.col2))
            cr:fill()
        end
   end

   return widget
end

-- ]]

return separators
