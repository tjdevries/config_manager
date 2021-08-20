vim.cmd [[
  func VimOld()
    let totallen = 0
    for i in range(1, 100000)
      call setline(i, '    ' .. getline(i))
      let totallen += len(getline(i))
    endfor
    return totallen
  endfunc
]]

_G.test_lua_via_fn = function()
  -- test via vim.fn
  local total_len = 0
  for i = 1, 100000 do
    vim.fn.setline(i, "    " .. vim.fn.getline(i))
    total_len = total_len + string.len(vim.fn.getline(i))
  end
  return total_len
end

_G.test_lua_naive = function()
  -- test via setting each line in loop (mirrors original test)
  local b = vim.api.nvim_get_current_buf()
  local total_len = 0
  for i = 1, 100000 do
    local lines = vim.api.nvim_buf_get_lines(b, i - 1, i, false)
    lines[1] = "    " .. lines[1]
    vim.api.nvim_buf_set_lines(b, i - 1, i, false, lines)
    total_len = total_len + string.len(lines[1])
  end
  return total_len
end

_G.test_lua_batch = function()
  -- test via getting all lines, updating in loop then setting post
  local b = vim.api.nvim_get_current_buf()
  local total_len = 0
  local a_get = vim.loop.hrtime()
  local lines = vim.api.nvim_buf_get_lines(b, 0, -1, false)
  local b_get = vim.loop.hrtime()
  local a_loop = vim.loop.hrtime()
  for i = 1, 100000 do
    lines[i] = "    " .. lines[i]
    total_len = total_len + string.len(lines[i])
  end
  local b_loop = vim.loop.hrtime()
  local a_set = vim.loop.hrtime()
  vim.api.nvim_buf_set_lines(b, 0, -1, false, lines)
  local b_set = vim.loop.hrtime()
  print(
    string.format(
      "test_lua_batch get: %dms, loop: %dms, set: %dms",
      ((b_get - a_get) / 1000000),
      ((b_loop - a_loop) / 1000000),
      ((b_set - a_set) / 1000000)
    )
  )

  return total_len
end

vim.cmd [[
  new
  call setline(1, range(100000))
  let start = reltime()
  echo VimOld()
  echo 'Vim old: ' .. reltimestr(reltime(start))
  bwipe!

  new
  call setline(1, range(100000))
  let start = reltime()
  lua print(test_lua_naive())
  echo 'Lua Naive: ' .. reltimestr(reltime(start))
  bwipe!

  new
  call setline(1, range(100000))
  let start = reltime()
  lua print(test_lua_batch())
  echo 'Lua Batch: ' .. reltimestr(reltime(start))
  bwipe!

  new
  call setline(1, range(100000))
  let start = reltime()
  lua print(test_lua_via_fn())
  echo 'lua.fn: ' .. reltimestr(reltime(start))
  bwipe!
]]
