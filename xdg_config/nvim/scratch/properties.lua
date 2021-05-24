
local properties = {
  showing = {
    get = function(t)
      print("Yoooo we're showing.")
      return 5
    end,

    set = function(t, v)
      error("This can't be ser.")
    end,
  }
}

local lookup = {}

local cls = setmetatable({}, {
  __index = function(t, k)
    if properties[k] then
      return properties[k].get(t)
    end

    return lookup[k]
  end,

  __newindex = function(t, k, v)
    if properties[k] then
      return properties[k].set(t, v)
    end

    lookup[k] = v
  end
})


print(cls.showing)

cls.example = true
print(cls.example)
cls.showing = 7
