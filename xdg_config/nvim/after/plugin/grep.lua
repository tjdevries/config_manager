local Job = require "plenary.job"

local grepper = {}

local get_job = function(str, cwd)
  local job = Job:new {
    command = "rg",
    args = { "--vimgrep", str },

    on_stdout = vim.schedule_wrap(function(_, line)
      local split_line = vim.split(line, ":")

      local filename = split_line[1]
      local lnum = split_line[2]
      local col = split_line[3]

      vim.fn.setqflist(
        {
          {
            filename = filename,
            lnum = lnum,
            col = col,
            text = split_line[4],
          },
        },
        "a"
      )
    end),

    on_exit = vim.schedule_wrap(function()
      vim.cmd [[copen]]
    end),
  }

  return job
end

grepper.grep_for_string = function(str, cwd)
  vim.fn.setqflist({}, "r")
  return get_job(str, cwd):join()
end

grepper.replace_string = function(search, replace, opts)
  opts = opts or {}

  local job = get_job(search, opts.cwd)
  job:add_on_exit_callback(vim.schedule_wrap(function()
    vim.cmd(string.format("cdo s/%s/%s/g", search, replace))
    vim.cmd [[cdo :update]]
  end))

  return job:sync()
end

-- grepper.grep_for_string('buf_get_prev_diagnostic')

vim.cmd [[nnoremap ,ff :lua R("tj.grep").grep_for_string(vim.fn.input("Grep For > "))<CR>]]
vim.cmd [[nnoremap ,fr :lua R("tj.grep").replace_string(vim.fn.input("Grep For > "), vim.fn.input("Replace with > "))<CR>]]

return grepper
