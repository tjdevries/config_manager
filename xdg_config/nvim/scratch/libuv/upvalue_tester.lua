
local CONST_UPVALUE = 3
local other_thing = "hello"

local x = function()
  return print(CONST_UPVALUE, other_thing)
end

local ok_types = {
  boolean = true,
  number = true,
  string = true
}

local cloner = function(to_clone)
  local upvalues = {}
  local index = 1
  local upvalue_name, upvalue_value
  while true do
    upvalue_name, upvalue_value = debug.getupvalue(to_clone, index)

    if not upvalue_name then
      break
    end

    local upvalue_type = type(upvalue_value)
    if not ok_types[upvalue_type] then
      error(string.format(
        "Unsupported type: %s %s %s"
        , upvalue_name, upvalue_value, upvalue_type
      ))
    end

    table.insert(upvalues, upvalue_value)
    index = index + 1
  end

  local result = table.concat(upvalues, "|")

  return result .. "~~~~~" .. string.dump(to_clone)
end

-- P(cloner(x))
print(string.dump(x))

-- print(string.dump(x))
-- print(debug.getupvalue(x, 1))

local f = assert(io.open("/home/tj/tmp/upvalued_function.lua", "w"))
f:write(cloner(x))
f:close()
