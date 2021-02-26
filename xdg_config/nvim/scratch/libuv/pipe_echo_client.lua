local uv = vim.loop

local SOCK = "/tmp/echo.sock"

local client = uv.new_pipe(false)
client:connect(SOCK, vim.schedule_wrap(function (err)
  vim.cmd[[sleep 1]]
  assert(not err, err)
  client:read_start(function (err, chunk)
    assert(not err, err)
    if chunk then
      print(chunk)
    else
      client:close()
    end
  end)

  client:write("Hello ")
  client:write("world!  !!")
end))

print("CTRL-C to break")

uv.run("default")
