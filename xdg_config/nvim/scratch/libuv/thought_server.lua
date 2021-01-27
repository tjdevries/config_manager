local uv = vim.loop

local SOCK = "/tmp/thoughts.sock"

TeleServer = uv.new_pipe(false)

local ret, err, code = TeleServer:bind(SOCK)
-- if file already exists, remove it first and try again
if not ret and code == "EADDRINUSE" then
  vim.loop.fs_unlink(SOCK)
  _, err, _ = TeleServer:bind(SOCK)
  assert(not err, err)
else
  assert(not err, err)
end

TeleServer:read_start(function(err, chunk)
  print("TELE SERVER", err, chunk)
end)

TeleServer:listen(128, function (err)
  assert(not err, err)
  local client = uv.new_pipe(true)
  TeleServer:accept(client)
  client:read_start(function (err, chunk)
    print(err, chunk)
    assert(not err, err)
    if chunk then
      print("Got New: " .. chunk)
      client:write(chunk)
    else
      client:shutdown()
      client:close()
    end
  end)
end)

uv.run("default")
