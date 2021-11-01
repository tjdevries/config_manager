--[[

     Licensed under MIT License
      * (c) 2013, Luca CPZ
      * (c) 2009, Uli Schlachter
      * (c) 2009, Majic

--]]

local format = string.format
local setmetatable = setmetatable

-- Lain markup util submodule
-- lain.util.markup
local markup = { fg = {}, bg = {} }

-- Convenience tags
function markup.bold(text)      return format("<b>%s</b>",         text) end
function markup.italic(text)    return format("<i>%s</i>",         text) end
function markup.strike(text)    return format("<s>%s</s>",         text) end
function markup.underline(text) return format("<u>%s</u>",         text) end
function markup.monospace(text) return format("<tt>%s</tt>",       text) end
function markup.big(text)       return format("<big>%s</big>",     text) end
function markup.small(text)     return format("<small>%s</small>", text) end

-- Set the font
function markup.font(font, text)
    return format("<span font='%s'>%s</span>", font, text)
end

-- Set the foreground
function markup.fg.color(color, text)
    return format("<span foreground='%s'>%s</span>", color, text)
end

-- Set the background
function markup.bg.color(color, text)
    return format("<span background='%s'>%s</span>", color, text)
end

-- Set foreground and background
function markup.color(fg, bg, text)
    return format("<span foreground='%s' background='%s'>%s</span>", fg, bg, text)
end

-- Set font and foreground
function markup.fontfg(font, fg, text)
    return format("<span font='%s' foreground='%s'>%s</span>", font, fg, text)
end

-- Set font and background
function markup.fontbg(font, bg, text)
    return format("<span font='%s' background='%s'>%s</span>", font, bg, text)
end

-- Set font, foreground and background
function markup.fontcolor(font, fg, bg, text)
    return format("<span font='%s' foreground='%s' background='%s'>%s</span>", font, fg, bg, text)
end

-- link markup.{fg,bg}(...) calls to markup.{fg,bg}.color(...)
setmetatable(markup.fg, { __call = function(_, ...) return markup.fg.color(...) end })
setmetatable(markup.bg, { __call = function(_, ...) return markup.bg.color(...) end })

-- link markup(...) calls to markup.fg.color(...)
return setmetatable(markup, { __call = function(_, ...) return markup.fg.color(...) end })
