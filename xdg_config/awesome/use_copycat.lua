local log = require "teej.log"

local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears = require "gears"
local awful = require "awful"
require "awful.autofocus"
local wibox = require "wibox"
local beautiful = require "beautiful"
local naughty = require "naughty"
local lain = require "lain"
--local menubar       = require("menubar")
local freedesktop = require "freedesktop"
local hotkeys_popup = require("awful.hotkeys_popup").widget
require "awful.hotkeys_popup.keys"
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi = require("beautiful.xresources").apply_dpi

local themes = {
  "blackburn", -- 1
  "copland", -- 2
  "dremora", -- 3
  "holo", -- 4
  "multicolor", -- 5
  "powerarrow", -- 6
  "powerarrow-dark", -- 7
  "rainbow", -- 8
  "steamburn", -- 9
  "vertex", -- 10
}

local chosen_theme = themes[6]

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv "HOME", chosen_theme))

log.info "Loaded beautiful init"
