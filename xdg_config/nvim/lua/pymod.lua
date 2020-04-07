package.loaded['pymod'] = nil

local vim = vim

local pymod = {}

pymod.printer = function()
  print('hi')
end

function pymod.find_module(mod_name)
  return  vim.fn.fnamemodify(
    vim.split(
      vim.fn.system(string.format('python -c "import %s; print(%s.__file__)"', mod_name, mod_name)),
      "\n"
    )[1],
    ":p:h"
  )
end

function pymod.list_possible_modules()
  local raw_json = vim.fn.system("pip list --format json")
  local options = vim.fn.json_decode(raw_json)

  local possible_matches = {}
  for _, dict in ipairs(options) do
    table.insert(possible_matches, dict["name"])
  end

  return possible_matches
end

return pymod
