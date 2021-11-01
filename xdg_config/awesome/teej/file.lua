local file = {}

file.write = function(name, contents)
  local f = io.open(name, "w")
  f:write(contents)
  f:close()
end

return file
