package.loaded['tj.nvim_dev'] = nil

local nvim_dev = {}

nvim_dev.run_this_test = function()
  local line = vim.fn.getline('.')

  local _, it_start = string.find(line, 'it(', 1, true)
  if not it_start then
    print("Could not find test to run: start")
    return
  end

  local _, it_finish = string.find(line, ',', 1, true)
  if not it_finish then
    print("Could not find test to run: finish")
    return
  end

  local test_filter = string.sub(line, it_start + 1, it_finish - 1)
  local test_file = vim.fn.expand("%:p")

  local command = string.format(
    "TEST_FILTER=%s TEST_FILE='%s' make functionaltest",
    test_filter,
    test_file
  )

  -- vim.fn.setreg('*', reg)
  vim.fn.setreg('+', command)

  -- TODO: Make this a nice floating window so I can drop having this window open.
end

return nvim_dev
