if vim.g.snippets ~= "luasnip" then
  return
end

local ls = require "luasnip"

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}

-- create snippet
-- s(context, nodes, condition, ...)
local snippet = ls.s
local snippet_from_nodes = ls.sn

-- This a choice snippet. You can move through with <c-e> (in my config)
-- tbl_snip {
--   trig = "c",
--   t { "-- this has a choice: " },
--   c(1, { t {"hello"}, t {"world"}, }),
--   i(0),
-- }
local c = ls.c -- choice node

local f = ls.f -- function node
local i = ls.i -- insert node
local t = ls.t -- text node
local d = ls.d -- dynamic node

local str = function(text)
  return t { text }
end

local newline = function(text)
  return t { "", text }
end

local str_snip = function(trig, expanded)
  return ls.parser.parse_snippet({ trig = trig }, expanded)
end

local tbl_snip = function(t)
  return snippet({ trig = t.trig, dscr = t.desc }, { unpack(t) })
end

local function char_count_same(c1, c2)
  local line = vim.api.nvim_get_current_line()
  local _, ct1 = string.gsub(line, c1, "")
  local _, ct2 = string.gsub(line, c2, "")
  return ct1 == ct2
end

local function neg(fn, ...)
  return not fn(...)
end

-- {{{ Go stuff
local ts_locals = require "nvim-treesitter.locals"
local ts_utils = require "nvim-treesitter.ts_utils"

local get_node_text = vim.treesitter.get_node_text

vim.treesitter.set_query("go", "LuaSnip_Result", [[
  [
    (method_declaration result: (*) @id)
    (function_declaration result: (*) @id)
    (func_literal result: (*) @id)
  ]
]])

local transform = function(text, info)
  if text == "int" then
    return str "0"
  elseif text == "error" then
    if info then
      info.index = info.index + 1

      return c(info.index, {
        str(string.format('errors.Wrap(%s, "%s")', info.err_name, info.func_name)),
        str(info.err_name),
      })
    else
      return str "err"
    end
  elseif text == "bool" then
    return str "false"
  elseif string.find(text, "*", 1, true) then
    return str "nil"
  end

  return str(text)
end

local handlers = {
  ["parameter_list"] = function(node, info)
    local result = {}

    local count = node:named_child_count()
    for i = 0, count - 1 do
      table.insert(result, transform(get_node_text(node:named_child(i), 0), info))
      if i ~= count - 1 then
        table.insert(result, t { ", " })
      end
    end

    return result
  end,

  ["type_identifier"] = function(node, info)
    local text = get_node_text(node, 0)
    return { transform(text, info) }
  end,
}

local function go_result_type(info)
  local cursor_node = ts_utils.get_node_at_cursor()
  local scope = ts_locals.get_scope_tree(cursor_node, 0)

  local function_node
  for _, v in ipairs(scope) do
    if
      v:type() == "function_declaration"
      or v:type() == "method_declaration"
      or v:type() == "func_literal"
    then
      function_node = v
      break
    end
  end

  local query = vim.treesitter.get_query("go", "LuaSnip_Result")
  for id, node in query:iter_captures(function_node, 0) do
    if handlers[node:type()] then
      return handlers[node:type()](node, info)
    end
  end
end
-- }}}
local shortcut = function(val)
  if type(val) == "string" then
    return { t { val }, i(0) }
  end

  if type(val) == "table" then
    for k, v in ipairs(val) do
      if type(v) == "string" then
        val[k] = t { v }
      end
    end
  end

  return val
end

local make = function(tbl)
  local result = {}
  for k, v in pairs(tbl) do
    table.insert(result, (snippet({ trig = k, desc = v.desc }, shortcut(v))))
  end

  return result
end

local same = function(index)
  return f(function(args)
    return args[1]
  end, { index })
end

local snippets = {}

snippets.all = {
  snippet({ trig = "(" }, { t { "(" }, i(1), t { ")" }, i(0) }, neg, char_count_same, "%(", "%)"),
}

--stylua: ignore
snippets.lua = make {
  ignore = "--stylua: ignore",

  lf = { 
    desc = "table function" ,
    "local ", i(1), " = function(", i(2), ")", newline "  ", i(0), newline "end",
  },

  -- TODO: I don't know how I would like to set this one up.
  f = { "function(", i(1), ")", i(0), newline "end" },

  test = { "mirrored: ", i(1), " // ", same(1), " | ", i(0)},

  -- test = { "local ", i(1), ' = require("', f(function(args)
  --   table.insert(RESULT, args[1])
  --   return { "hi" }
  -- end, { 1 }), '")', i(0) },

  -- test = { i(1), " // ", d(2, function(args)
  --   return snippet_from_nodes(nil, { str "hello" })
  -- end, { 1 }), i(0) },
}

local go_ret_vals = function(args, old_state)
  local info = { index = 0, err_name = args[1][1], func_name = args[2][1] }
  return snippet_from_nodes(nil, go_result_type(info))
end

--stylua: ignore
snippets.go = make {
  main = {
    t { "func main() {", "\t" },
    i(0),
    t { "", "}" },
  },

  ef = {
    i(1, { "val" }), str ", err := ", i(2, { "f" }), str "(", i(3), str ")", i(0),
  },

  efi = { 
    i(1, { "val" }), ", ", i(2, { "err" }), " := ", i(3, { "f" }), "(", i(4), ")",
    t { "", "if ", }, same(2), t {" != nil {", "\treturn ", }, d(5, go_ret_vals, {2, 3}), t { "", "}" },
    i(0),
  },

  -- TODO: Fix this up so that it actually uses the tree sitter thing
  ie = { "if err != nil {", "\treturn err", i(0), "}" },
}

ls.snippets = snippets

vim.cmd [[
  imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
  inoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>

  imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

  snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(1)<CR>
  snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
]]
