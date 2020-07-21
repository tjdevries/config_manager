
local log = {}

local function do_log(level, fmt, ...)
  local file = io.open('/home/tj/awesome.log', 'a')

  file:write(string.format(
    "%s : %s\n",
    level,
    string.format(fmt, ...)
  ))

  file:close()
end

log.info = function(fmt, ...)
  do_log('info', fmt, ...)
end

return log
