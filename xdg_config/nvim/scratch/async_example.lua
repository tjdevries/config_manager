local uv = vim.loop

local async

async = uv.new_async(function()
  uv.sleep(1000)
  print "yoo, hello"
  async:close()
end)

print "first"
async:send()
