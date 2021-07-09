local uv = require "luv"

-- {{{ Colors
local colors = {
  BLACK = 30,
  RED = 31,
}

-- 39	Default foreground color
-- 32	Green
-- 33	Yellow
-- 34	Blue
-- 35	Magenta
-- 36	Cyan
-- 37	Light gray
-- 90	Dark gray
-- 91	Light red
-- 92	Light green
-- 93	Light yellow
-- 94	Light blue
-- 95	Light magenta
-- 96	Light cyan
-- 97	White
-- }}}

-- local _git_dir_cache = {}
-- local is_git_dir = function(dir)
-- end

local function capture(cmd, raw)
  local f = io.popen(cmd, "r")
  local s = assert(f:read "*a")
  f:close()
  if raw then
    return s
  end
  s = string.gsub(s, "^%s+", "")
  s = string.gsub(s, "%s+$", "")
  s = string.gsub(s, "[\n\r]+", " ")
  return s
end

local inspect = require "inspect"

local prompt = {}

local ret_code = arg[1]

local pwd = os.getenv "PWD"
local home = os.getenv "HOME"

local path = string.gsub(pwd, home, "~")

if false then
  local is_git_repo = os.execute "git rev-parse --is-inside-work-tree" == 0
  if is_git_repo then
    table.insert(prompt, "GIT")
  end

  local j = uv.spawn("git", {
    args = { "rev-parse", "--is-inside-work-tree" },
    on_stdout = function()
      print "stdout"
    end,
    on_exit = function()
      print "EXIT"
    end,
  })

  table.insert(prompt, tostring(j))
end

-- local branch = capture('git branch')

table.insert(prompt, path)

if ret_code ~= "0" then
  table.insert(prompt, string.format("\27[%sm > \27[0m", 31))
else
  table.insert(prompt, " >  ")
end

print(table.concat(prompt, ""))
