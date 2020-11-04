
local f = assert(io.open("/home/tj/tmp/upvalued_function.lua", "r"))
local read_value = f:read("*a")
f:close()

local split_file = vim.split(read_value, "~~~~~")
local upvalues = vim.split(split_file[1], "|")
local loaded_function, err = loadstring(split_file[2])
if err then
  print(split_file[2])
  print(err)
  return
end

for up, value in ipairs(upvalues) do
  debug.setupvalue(loaded_function, up, value)
end

loaded_function()
