local uv = require('luv')

-- print(vim.inspect(uv))


local my_table = {}
local my_value = 1

local table_adder = false and uv.new_thread(function(new_path)
  package.path = new_path
  -- table.insert(tbl, "HELLO")
  local uv = require('luv')
  -- print(uv)

  local fzy_sorter = require('telescope.algos.fzy')
  -- print(fzy_sorter)
  print(fzy_sorter.score("helo", "hello"))
end, package.path)

local pipe = uv.new_pipe(false)

pipe:bind('/tmp/sock.test')
pipe:read_start(function(err, data)
  vim.schedule(function()
    print(err, data)
  end)
end)

pipe:listen(128, function()
  local client = uv.new_pipe(false)
  pipe:accept(client)
  client:write("hello!\n")
  client:write("hello!\n")
  client:write("hello!\n")
  uv.sleep(100)
  client:write("hello!\n")
  client:write("hello!\n")
  client:write("hello!\n")
  client:close()
end)

if table_adder then
  uv.thread_join(table_adder)
end
-- print(vim.inspect(MY_TABLE))

--[[
normally, you have `vim` as a global

What if we make a NEW global, with the same INTERFACE as vim (or limited same interace)
but make it do stuff like communicate via RPC w/ nvim!!!!!!

WE ALREAYD HAVE RPC FOR ALL THE COOL STUFF BASICALLY

vim.api -> makes rpc request, waits for request to complete, does stuff.
--]]

