RELOAD("tj.nvim_dev")

local Job = require('plenary.job')
local plenary_window = require('plenary.window.float')

local nnoremap = vim.keymap.nnoremap

local nvim_dev = {}

nvim_dev.run_this_test = function()
  local line = vim.fn.getline('.')
  if not string.find(line, 'it(', 1, true) then
    local pos = vim.api.nvim_win_get_cursor(0)
    local row = pos[1]

    repeat
      row = row - 1

      if row <= 0 then
        break
      end

      line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
    until string.find(line, 'it(', 1, true)
  end

  local _, it_start = string.find(line, 'it(', 1, true)
  if not it_start then
    print("Could not find test to run: start")
    return
  end

  local it_finish = string.find(line, ', function', 1, true)
  if not it_finish then
    print("Could not find test to run: finish")
    return
  end

  local test_filter = string.sub(line, it_start + 1, it_finish - 1)
    :gsub("'", "")
    :gsub('"', '')

  local test_file = vim.fn.expand("%:p")

  local command = string.format(
    "TEST_FILTER=%s TEST_FILE='%s' make functionaltest",
    vim.fn.shellescape(test_filter),
    test_file
  )

  -- print("Running command", command)
  vim.g.last_run = command

  plenary_window.percentage_range_window(0.9, 0.8)
  vim.fn.termopen(command)
end

nvim_dev.run_this_file = function()
  local test_file = vim.fn.expand("%:p")

  local command = string.format(
    "BUSTED_ARGS='--no-keep-going' TEST_FILE=%s make functionaltest",
    vim.fn.shellescape(test_file)
  )

  -- print("Running command", command)
  -- vim.fn.setreg('*', reg)
  -- vim.fn.setreg('+', command)
  vim.g.last_run = command

  plenary_window.percentage_range_window(0.9, 0.8)
  vim.fn.termopen(command)
end

nvim_dev.make = function()
  Job:new {
    command = "make",
    -- args

    on_stdout = vim.schedule_wrap(function(_, data)
      -- print(data)
    end),

    on_stderr = vim.schedule_wrap(function(_, data)
      -- print(data)
    end),

    on_exit = vim.schedule_wrap(function(self, code)
      print("Done")
      print("Code", code)
      if code ~= 0 then
        local result = vim.deepcopy(self:result())
        vim.list_extend(result, self:stderr_result())

        P(result)

        vim.fn.setqflist(result, 'r')
      end
    end),
  }:start()
end

nnoremap { "<space>tt", nvim_dev.run_this_test }
nnoremap { "<space>tf", nvim_dev.run_this_file }
nnoremap { "<space>m", nvim_dev.make }

return nvim_dev
