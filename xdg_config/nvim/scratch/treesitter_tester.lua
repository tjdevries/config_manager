

local x = function() end
local y = function() end

local function something(a, b, c)
  return a, b, c
end

local function other()
  return 5
end

something({
  was_first = true,
}, function()
  return {
    a = true, b = false,
  }
end, 3)

local ffi = require('ffi')

ffi.cdef [[
  int main(void) {
    return 5
  }
]]


local x = {1, 2, 3}
local y = {2, 3, 4}


if x then
  x = x + 5
  return 5
end
