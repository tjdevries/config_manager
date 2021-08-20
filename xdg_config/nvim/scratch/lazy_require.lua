local lazy_require = function(name)
  local mod

  return setmetatable({}, {
    __index = function(t, key)
      if not mod then
        mod = require(name)
      end

      return mod[key]
    end,

    __newindex = function(t, key, value)
      if not mod then
        mod = require(name)
      end

      mod[key] = value
    end,

    __call = function(_, ...)
      if not mod then
        mod = require(name)
      end

      return mod(...)
    end,
  })
end

local laziest_require = function(name)
  return setmetatable({}, {
    __index = function(t, k)
      print "indexing..."
      return function(...)
        print "calling..."
        return require(name)[k](...)
      end
    end,
  })
end

local l = laziest_require("tj.repl").set_job_id

print "later..."
l(1)
