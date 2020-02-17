-- I don't think this really works the way that I want it too... :'(
function FuncSign(f)
   assert(type(f) == 'function', "bad argument #1 to 'funcsign' (function expected)")
   local p = {}
   pcall(
      function()
         local oldhook
         local delay = 2
         local function hook(event, line)
            delay = delay - 1
            if delay == 0 then
               for i = 1, math.huge do
                  local k, v = debug.getlocal(2, i)
                  if type(v) == "table" then
                     table.insert(p, "...")
                     break
                  elseif (k or '('):sub(1, 1) == '(' then
                     break
                  else
                     table.insert(p, k)
                  end
               end
               if debug.getlocal(2, -1) then
                  table.insert(p, "...")
               end
               debug.sethook(oldhook)
               error('aborting the call')
            end
         end
         oldhook = debug.sethook(hook, "c")
         local arg = {}
         for j = 1, 64 do arg[#arg + 1] = true end
         f((table.unpack or unpack)(arg))
      end)
   return "function("..table.concat(p, ",")..")"
end
