-- Use this code to generate all the things
function keymap._generate_keymap_codes()
  local map_prefix = {
    '',
    'n',
    'v',
    'x',
    's',
    'o',
    'i',
    'l',
    'c',
    't',
  }

  local result = {
    "-- BEGIN GENERATED",
    "",
  }

  for _, prefix in ipairs(map_prefix) do

    local usage_example
    if prefix == 'n' then
      usage_example = [[
--- <pre>
---   vim.keymap.nmap { 'lhs', function() print("real lua function") end, silent = true }
--- </pre>
--@param opts (table): A table with keys:
---     - [1] = left hand side: Must be a string
---     - [2] = right hand side: Can be a string OR a lua function to execute
---     - Other keys can be arguments to |:map|, such as "silent". See |nvim_set_keymap()|
--- ]]
    else
      usage_example = [[--@see |vim.keymap.nmap|]]
    end

    table.insert(result, (string.format([[
--- Helper function for ':%smap'.
---
%s
---
function keymap.%smap(opts)
  return make_mapper('%s', { noremap = false })(opts)
end

--- Helper function for ':%snoremap'
%s
---
function keymap.%snoremap(opts)
  return make_mapper('%s', { noremap = true })(opts)
end
]], prefix, usage_example, prefix, prefix, prefix, usage_example, prefix, prefix)))
  end

  table.insert(result, "")
  table.insert(result, "-- END GENERATED")
  table.insert(result, "")
  table.insert(result, "return keymap")

  return vim.split(table.concat(result, "\n"), "\n")
end

local generating = false
if generating then
  vim.api.nvim_buf_set_lines(0, -1, -1, false, keymap._generate_keymap_codes())
end
