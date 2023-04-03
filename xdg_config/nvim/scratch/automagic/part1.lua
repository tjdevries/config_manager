local make_key = function(entry)
  return string.format("%s/%s", entry.Package, entry.Test)
end

local add_golang_test = function(state, entry)
  state.tests[make_key(entry)] = { name = entry.Test, output = {} }
end

local add_golang_output = function(state, entry)
  table.insert(state.tests[make_key(entry)].output, entry.Output)
end

local mark_success = function(state, entry)
  state.tests[make_key(entry)].success = entry.Action == "pass"
end

-- local display_golang_output = function(state, bufnr) end

local test_function_query_string = [[
(
 (function_declaration
  name: (identifier) @name
  parameters:
    (parameter_list
     (parameter_declaration
      name: (identifier)
      type: (pointer_type
          (qualified_type
           package: (package_identifier) @_package_name
           name: (type_identifier) @_type_name)))))

 (#eq? @_package_name "testing")
 (#eq? @_type_name "T")
 (#eq? @name "%s")
)
]]

local find_test_line = function(go_bufnr, name)
  local query = vim.treesitter.query.parse("go", string.format(test_function_query_string, name))
  local parser = vim.treesitter.get_parser(go_bufnr, "go", {})
  local tree = parser:parse()[1]
  local root = tree:root()

  for id, node, metadata in query:iter_captures(root, go_bufnr, 0, -1) do
    if id == 1 then
      print(id, node, metadata)
      print("Location:", node:range())
      return ({ node:range() })[1]
    end
  end
end

local ns = vim.api.nvim_create_namespace "live-tests"

local attach_to_buffer = function(go_bufnr, output_bufnr, command)
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup(string.format("teej-automagic-%s", go_bufnr), { clear = true }),
    pattern = "*.go",
    callback = function()
      local go_win = vim.api.nvim_get_current_win()
      vim.api.nvim_buf_clear_namespace(go_bufnr, ns, 0, -1)

      local state = { tests = {} }

      vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { "main.go output:" })
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = function(_, data)
          if data then
            for _, line in ipairs(data) do
              local decoded = vim.json.decode(line)
              -- vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, vim.split(vim.inspect(decoded), "\n"))
              if decoded.Action == "run" then
                add_golang_test(state, decoded)
              elseif decoded.Action == "output" then
                add_golang_output(state, decoded)
              elseif decoded.Action == "pass" or decoded.Action == "fail" then
                mark_success(state, decoded)
              else
                error("Failed to handle" .. vim.inspect(data))
              end
            end
          end
        end,
        on_stderr = function(_, data)
          if data then
            vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
          end
        end,

        on_exit = function()
          local failed = {}
          for key, test in pairs(state.tests) do
            local test_line = find_test_line(go_bufnr, test.name)
            if test_line then
              local text
              if test.success then
                text = { "✓" }
              else
                text = { "×", "Error" }
              end

              vim.api.nvim_buf_set_extmark(go_bufnr, ns, test_line, 0, {
                virt_text = { text },
              })
            end

            if not test.success then
              table.insert(failed, {
                bufnr = go_bufnr,
                lnum = test_line,
                col = 0,
                severity = vim.diagnostic.severity.ERROR,
                source = "go-test",
                message = string.format("golang test failed: %s", test.name),
                user_data = {},
              })
            end

            local output = {
              string.format("Test: %s %s", key, test.success and "✓" or "×"),
            }
            for _, line in ipairs(test.output) do
              if not test.success then
                vim.list_extend(output, vim.split(line, "\n"))
              end
            end

            vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, output)
          end

          -- vim.fn.setloclist(go_win, failed, "r")
          -- if #failed > 0 then
          --   vim.cmd.lopen()
          --   vim.cmd.lfirst()
          -- end
          vim.diagnostic.set(ns, go_bufnr, failed, {})
        end,
      })
    end,
  })
end

-- attach_to_buffer(80, { "go", "run", "main.go" })
attach_to_buffer(1, 6, { "go", "test", "./...", "-v", "-json" })
