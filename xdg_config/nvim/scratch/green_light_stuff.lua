local TestRun = R('gl.test').TestRun

local run = TestRun:new {
  test_pattern = nil,
  file_pattern = './...',
  cwd = vim.loop.cwd(),
}

run:run()
