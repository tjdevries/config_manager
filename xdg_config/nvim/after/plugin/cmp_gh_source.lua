local Job = require "plenary.job"

local source = {}

source.new = function()
  local self = setmetatable({ cache = {} }, { __index = source })

  return self
end

source.complete = function(self, _, callback)
  local bufnr = vim.api.nvim_get_current_buf()

  -- This just makes sure that we only hit the GH API once per session.
  --
  -- You could remove this if you wanted, but this just makes it so we're
  -- good programming citizens.
  if not self.cache[bufnr] then
    Job
      :new({
        -- Uses `gh` executable to request the issues from the remote repository.
        "gh",
        "issue",
        "list",
        "--limit",
        "1000",
        "--json",
        "title,number,body",

        on_exit = function(job)
          local result = job:result()
          local ok, parsed = pcall(vim.json.decode, table.concat(result, ""))
          if not ok then
            vim.notify "Failed to parse gh result"
            return
          end

          local items = {}
          for _, gh_item in ipairs(parsed) do
            gh_item.body = string.gsub(gh_item.body or "", "\r", "")

            table.insert(items, {
              label = string.format("#%s", gh_item.number),
              documentation = {
                kind = "markdown",
                value = string.format("# %s\n\n%s", gh_item.title, gh_item.body),
              },
            })
          end

          callback { items = items, isIncomplete = false }
          self.cache[bufnr] = items
        end,
      })
      :start()
  else
    callback { items = self.cache[bufnr], isIncomplete = false }
  end
end

source.get_trigger_characters = function()
  return { "#" }
end

source.is_available = function()
  return vim.bo.filetype == "gitcommit"
end

require("cmp").register_source("gh_issues", source.new())
