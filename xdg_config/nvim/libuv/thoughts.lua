
local uv = vim.loop
local addr = "/tmp/thoughts.sock"

local thread_entry = function(sorter, sock_addr)
  local uv = require('luv')

  -- Make sure this is always safe to import.
  --    no `vim` references at all anywhere.
  --
  -- NOTE: This should do the cool upvalue deserializing we made.
  local fzy = loadstring(sorter, 'sorter')()

  local client = uv.new_pipe(true)
  client:connect(sock_addr, function(err)
    if err then
      return
    end

    client:read_start(function(err, chunk)
      if err then
        client:close()
        return
      end

      if chunk then
        local start = string.find(chunk, "||||")
        local needle = string.sub(chunk, 1, start)
        local haystack = string.sub(chunk, start + 1)

        client:write(fzy.score(needle, haystack))
      else
        client:close()
      end
    end)
  end)
end

if true then
  thread_entry(package.path, addr)
else
  uv.new_thread(thread_entry, package.path, addr)
end
