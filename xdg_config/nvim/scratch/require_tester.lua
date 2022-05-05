local name = "cmp"

local find_module = function(name)
  local loaders = package.loaders
  for idx, loader in ipairs(package.loaders) do
    local l = loader(name)
    if type(l) == "function" then
      local info = debug.getinfo(l)
      print("Source File:", info.source)
    end
  end
end

find_module(name)
