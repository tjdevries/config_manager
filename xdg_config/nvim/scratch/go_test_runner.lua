local c = require('colorbuddy.color').colors
local Group = require('colorbuddy.group').Group

Group.new('GoTestSuccess', c.green, nil, s.bold)
Group.new('GoTestFail', c.red, nil, s.bold)

local a = vim.api

local Job = require('plenary.job')

local ns_gotest = a.nvim_create_namespace('gotest')

local test_run = "~ Go Test ~"
TestRuns = {
  [test_run] = {
    output = {}
  }
}

TestOrdered = { test_run }

local header_ids, count = {}, 0
local get_header_id_start = function(header)
  header = header .. "_start"
  if not header_ids[header] then
    count = count + 1
    header_ids[header] = count
  end

  return header_ids[header]
end

local get_header_id_final = function(header)
  header = header .. "_end"
  if not header_ids[header] then
    count = count + 1
    header_ids[header] = count
  end

  return header_ids[header]
end

local add_header_row = function(bufnr, name, test_obj)
  local line = "===== " .. name .. " ====="

  vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { line, "" })
  a.nvim_buf_set_extmark(bufnr, ns_gotest, vim.api.nvim_buf_line_count(bufnr) - 2, 0, { id = get_header_id_start(name) })
  a.nvim_buf_set_extmark(bufnr, ns_gotest, vim.api.nvim_buf_line_count(bufnr) - 1, 0, { id = get_header_id_final(name) })
end

local get_header_row = function(bufnr, name, final)
  local extmark_id = final and get_header_id_final(name) or get_header_id_start(name)
  local extmark_locations = vim.api.nvim_buf_get_extmark_by_id(bufnr, ns_gotest, extmark_id, {})
  return extmark_locations[1]
end

local add_header_content = function(bufnr, name, contents)
  local header_row = get_header_row(bufnr, name, false)
  if not header_row then
    print("Couldnt find for: ", name, contents)
    return
  end

  a.nvim_buf_set_lines(bufnr, header_row + 1, header_row + 1, false, contents)
end

local append_header_content = function(bufnr, name, contents)
  local header_row = get_header_row(bufnr, name, true)
  if not header_row then
    print("Couldnt find for: ", name, contents)
    return
  end

  a.nvim_buf_set_lines(bufnr, header_row, header_row, false, contents)
end

local highlight_result = function(bufnr, name, test_obj) local highlight_name
    if test_obj.result == "pass" then
      highlight_name = 'GoTestSuccess'
    elseif test_obj.result == "fail" then
      highlight_name = 'GoTestFail'
    else
      highlight_name = 'Error'
      -- TODO
    end

    local extmark_row = get_header_row(bufnr, name)
    if not extmark_row then
      print("COULD NOT GET ROW", extmark_row, bufnr, name)
      return
    end

    a.nvim_buf_add_highlight(bufnr, ns_gotest, highlight_name, extmark_row, 0, -1)
end

local bufnr = 195

a.nvim_buf_clear_namespace(0, ns_gotest, 0, -1)
a.nvim_buf_clear_namespace(bufnr, ns_gotest, 0, -1)

local j = Job:new {
  command = 'go',
  args = { 'test', '-json', '-run', 'TestIndexer', '/home/tj/sourcegraph/lsif-go/internal/indexer/' },
  -- args = { 'test', '-json', '-run', '', '/home/tj/sourcegraph/lsif-go/internal/...' },

  on_stdout = vim.schedule_wrap(function(_, line)
    local decoded = vim.fn.json_decode(line)

    local action = decoded.Action
    local test = decoded.Test or test_run

    if action == "run" then
      table.insert(TestOrdered, decoded.Test)

      TestRuns[test] = {
        decoded = decoded,
        output = {},
        result = "pending",
        extmark_id = get_header_id_start(test)
      }

      add_header_row(bufnr, test, TestRuns[test])
      return
    end

    if not TestRuns[test] then
      TestRuns[test] = {
        decoded = decoded,
        output = {},
        result = "pending",
        extmark_id = get_header_id_start(test)
      }
    end

    if action == "output" then
      table.insert(TestRuns[test].output, decoded.Output)
      append_header_content(bufnr, test, vim.split(vim.trim(decoded.Output), "\n"))
    elseif action == "pass" then
      TestRuns[test].result = "pass"
      highlight_result(bufnr, test, TestRuns[test])
    elseif action == "fail" then
      TestRuns[test].result = "fail"
      highlight_result(bufnr, test, TestRuns[test])
    else
      print("Missing this one", vim.inspect(decoded))
    end
  end),

  on_exit = vim.schedule_wrap(function()
    -- put all the things in a window
    -- local results = self:result()

    for _, name in pairs(TestOrdered) do
      local test = TestRuns[name]

      local contents = {}
      for _, val in ipairs(vim.split(vim.inspect(test), "\n")) do
        table.insert(contents, val)
      end

      -- add_header_content(bufnr, name, contents)
    end
  end),
}

print("ns_gotest:", ns_gotest)
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})

j:start()
-- j:wait()
