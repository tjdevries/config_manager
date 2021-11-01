local M = {}

function M.tbl_islist(t)
  if type(t) ~= "table" then
    return false
  end

  local count = 0

  for k, _ in pairs(t) do
    if type(k) == "number" then
      count = count + 1
    else
      return false
    end
  end

  if count > 0 then
    return true
  else
    return false
  end
end

local function tbl_extend(behavior, deep_extend, ...)
  if behavior ~= "error" and behavior ~= "keep" and behavior ~= "force" then
    error('invalid "behavior": ' .. tostring(behavior))
  end

  if select("#", ...) < 2 then
    error("wrong number of arguments (given " .. tostring(1 + select("#", ...)) .. ", expected at least 3)")
  end

  local ret = {}
  for i = 1, select("#", ...) do
    local tbl = select(i, ...)
    if tbl then
      for k, v in pairs(tbl) do
        if type(v) == "table" and deep_extend and not M.tbl_islist(v) then
          ret[k] = tbl_extend(behavior, true, ret[k] or {}, v)
        elseif behavior ~= "force" and ret[k] ~= nil then
          if behavior == "error" then
            error("key found in more than one map: " .. k)
          end -- Else behavior is "keep".
        else
          ret[k] = v
        end
      end
    end
  end
  return ret
end

--- Merges two or more map-like tables.
---
--@see |extend()|
---
--@param behavior Decides what to do if a key is found in more than one map:
---      - "error": raise an error
---      - "keep":  use value from the leftmost map
---      - "force": use value from the rightmost map
--@param ... Two or more map-like tables.
function M.tbl_extend(behavior, ...)
  return tbl_extend(behavior, false, ...)
end

--- Merges recursively two or more map-like tables.
---
--@see |tbl_extend()|
---
--@param behavior Decides what to do if a key is found in more than one map:
---      - "error": raise an error
---      - "keep":  use value from the leftmost map
---      - "force": use value from the rightmost map
--@param ... Two or more map-like tables.
function M.tbl_deep_extend(behavior, ...)
  return tbl_extend(behavior, true, ...)
end

return M
