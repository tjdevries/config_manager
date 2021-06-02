if vim.g.snippets ~= "luasnip" then
  return
end

local ls = require "luasnip"

-- create snippet
-- s(context, nodes, condition, ...)
local s = ls.s

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

local str_snip = function(trig, expanded)
  return ls.parser.parse_snippet({ trig = trig }, expanded)
end

local tbl_snip = function(t)
  return s({ trig = t.trig, dscr = t.desc }, { unpack(t) })
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

local snippets = {}

snippets.all = {
  s({ trig = "(" }, { t { "(" }, i(1), t { ")" }, i(0) }, neg, char_count_same, "%(", "%)"),
}

--stylua: ignore
snippets.lua = {
  str_snip("ignore", "--stylua: ignore"),
  s({ trig = "tf", dscr = "table function" }, { t { "function", "hello" }, i(1), t { "(" }, i(2), t { ")" }, i(0) }),
  tbl_snip {
    trig = "f",
    desc = "function",
    t { "function " }, i(1), t { "(" }, i(2), t { ")" }, i(0),
  },

}

ls.snippets = snippets

vim.cmd [[
  imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
  imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

  snoremap <silent> <Tab> <cmd>lua ls.jump(1)<Cr>
  snoremap <silent> <S-Tab> <cmd>lua ls.jump(-1)<Cr>
]]

--[[
local ls = require'luasnip'
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d

local function copy(args)
	return args[1]
end

local function char_count_same(c1, c2)
	local line = vim.api.nvim_get_current_line()
	local _, ct1 = string.gsub(line, c1, '')
	local _, ct2 = string.gsub(line, c2, '')
	return ct1 == ct2
end

local function even_count(c)
	local line = vim.api.nvim_get_current_line()
	local _, ct = string.gsub(line, c, '')
	return ct % 2 == 0
end

local function neg(fn, ...)
	return not fn(...)
end

local function jdocsnip(args, old_state)
	local nodes = {
		t({"/**"," * "}),
		i(1, {"A short Description"}),
		t({"", ""})
	}

	-- These will be merged with the snippet; that way, should the snippet be updated,
	-- some user input eg. text can be referred to in the new snippet.
	local param_nodes = {}

	if old_state then
		nodes[2] = i(1, old_state.descr:get_text())
	end
	param_nodes.descr = nodes[2]

	-- At least one param.
	if string.find(args[2][1], ", ") then
		vim.list_extend(nodes, {t({" * ", ""})})
	end

	local insert = 2
	for indx, arg in ipairs(vim.split(args[2][1], ", ", true)) do
		-- Get actual name parameter.
		arg = vim.split(arg, " ", true)[2]
		if arg then
			local inode
			-- if there was some text in this parameter, use it as static_text for this new snippet.
			if old_state and old_state["arg"..arg] then
				inode = i(insert, old_state["arg"..arg]:get_text())
			else
				inode = i(insert)
			end
			vim.list_extend(nodes, {t({" * @param "..arg.." "}), inode, t({"", ""})})
			param_nodes["arg"..arg] = inode

			insert = insert + 1
		end
	end

	if args[1][1] ~= "void" then
		local inode
		if old_state and old_state.ret then
			inode = i(insert, old_state.ret:get_text())
		else
			inode = i(insert)
		end

		vim.list_extend(nodes, {t({" * ", " * @return "}), inode, t({"", ""})})
		param_nodes.ret = inode
		insert = insert + 1
	end

	if vim.tbl_count(args[3]) ~= 1 then
		local exc = string.gsub(args[3][2], " throws ", "")
		local ins
		if old_state and old_state.ex then
			ins = i(insert, old_state.ex:get_text())
		else
			ins = i(insert)
		end
		vim.list_extend(nodes, {t({" * ", " * @throws "..exc.." "}), ins, t({"", ""})})
		param_nodes.ex = ins
		insert = insert + 1
	end

	vim.list_extend(nodes, {t({" */"})})

	local snip = sn(nil, nodes)
	-- Error on attempting overwrite.
	snip.old_state = param_nodes
	return snip
end

ls.snippets = {
	all = {
		s({trig="("}, { t({"("}), i(1), t({")"}), i(0) }, neg, char_count_same, '%(', '%)'),
		s({trig="{"}, { t({"{"}), i(1), t({"}"}), i(0) }, neg, char_count_same, '%{', '%}'),
		s({trig="["}, { t({"["}), i(1), t({"]"}), i(0) }, neg, char_count_same, '%[', '%]') ,
		s({trig="<"}, { t({"<"}), i(1), t({">"}), i(0) }, neg, char_count_same, '<', '>'),
		s({trig="'"}, { t({"'"}), i(1), t({"'"}), i(0) }, neg, even_count, '\''),
		s({trig="\""}, { t({"\""}), i(1), t({"\""}), i(0) }, neg, even_count, '"'),
		s({trig="{;"}, { t({"{","\t"}), i(1), t({"", "}"}), i(0) }),
	},
	java = {
		s({trig="fn"}, {
			d(6, jdocsnip, {2, 4, 5}), t({"", ""}),
			c(1, {
				t({"public "}),
				t({"private "})
			}),
			c(2, {
				t({"void"}),
				i(nil, {""}),
				t({"String"}),
				t({"char"}),
				t({"int"}),
				t({"double"}),
				t({"boolean"}),
			}),
			t({" "}),
			i(3, {"myFunc"}),
			t({"("}), i(4), t({")"}),
			c(5, {
				t({""}),
				sn(nil, {
					t({""," throws "}),
					i(1)
				})
			}),
			t({" {", "\t"}),
			i(0),
			t({"", "}"})
		})
	},
	rust = {
		ls.parser.parse_snippet({trig = "fn"}, "/// $1\nfn $2($3) ${4:-> $5 }\\{\n\t$0\n\\}")
	}
}
--]]
