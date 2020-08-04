--[[
;; Functions definitions
(function_declarator
  declarator: (identifier) @definition.function)
(preproc_function_def
  name: (identifier) @definition.macro) @scope

(preproc_def
  name: (identifier) @definition.macro)
(pointer_declarator
  declarator: (identifier) @definition.var)
(parameter_declaration
  declarator: (identifier) @definition.var)
(init_declarator
  declarator: (identifier) @definition.var)
(array_declarator
  declarator: (identifier) @definition.var)
(declaration
  declarator: (identifier) @definition.var)
(enum_specifier
  name: (_) @definition.type
  (enumerator_list
    (enumerator name: (identifier) @definition.var)))

;; Type / Struct / Enum
(field_declaration
  declarator: (field_identifier) @definition.field)
(type_definition
  declarator: (type_identifier) @definition.type)
(struct_specifier
  name: (type_identifier) @definition.type)

;; References
(identifier) @reference
((type_identifier) @reference
                   (set! reference.kind "type"))

;; Scope
[
 (for_statement)
 (if_statement)
 (while_statement)
 (translation_unit)
 (function_definition)
 (compound_statement) ; a block in curly braces
] @scope
--]]

local Match = {}
Match.__index = Match
Match.__tostring = function(self)
  if #self.args == 1 and type(self.args[1]) == 'string' then
    return self.args[1]
  end
end

function Match.new(...)
  return setmetatable({ args = {...}}, Match)
end

local Rule = {}
Rule.__index = Rule

function Rule.new(name, match)
  return setmetatable({name = name, match = match}, Rule)
end

local function new_scheme()
  return setmetatable({}, {
    __newindex = function(t, k, v)
      table.insert(t, Rule.new(k, Match.new(v)))
    end
  })
end

local defs = new_scheme()
defs.identifier = "@reference"
defs.override = "does not show"

local child_defs = new_scheme()
defs.other_identifier = "@other.reference"
defs.override = "@should.show"

---
-- Parameters: ~
--     {behavior}  Decides what to do if a key is found in more
--                 than one map:
--                 • "error": raise an error
--                 • "keep": use value from the leftmost map
--                 • "force": use value from the rightmost map
local extend_scheme = function(behavior, parent, child)
  local resulting_matches = {}
  for _, parent_value in ipairs(parent) do
    table.insert(resulting_matches, parent_value)
  end

  for _, child_value in ipairs(child) do
    local found_parent = false
    for index, parent_value in ipairs(parent) do
      if parent_value.name == child_value.name then
        resulting_matches[index] = child_value
        found_parent = true
      end
    end

    if not found_parent then
      table.insert(resulting_matches, child_value)
    end
  end

  return resulting_matches
end

local generate_scheme = function(t)
  local lines = {}
  for _, rule in ipairs(t) do
    -- for _, rule in ipairs(v) do
      table.insert(lines, string.format("(%s) %s", rule.name, rule.match))
    -- end
  end

  return lines
end

local do_func
if false then
  do_func = function(x) 
    vim.api.nvim_buf_set_lines(0, -1, -1, false, x)
  end
else
  do_func = function(x)
    print(vim.inspect(x))
  end
end

do_func(generate_scheme(extend_scheme('', defs, child_defs)))

--[[
(identifier) @reference
(override) @should.show
(other_identifier) @other.reference
--]]
