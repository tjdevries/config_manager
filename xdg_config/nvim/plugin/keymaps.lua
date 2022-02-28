local curl = require "plenary.curl"

local nmap = require("tj.keymap").nmap

nmap {
  "<M-j>",
  function()
    if vim.opt.diff:get() then
      vim.cmd [[normal! ]c]]
    else
      vim.cmd [[m .+1<CR>==]]
    end
  end,
}

nmap {
  "<M-k>",
  function()
    if vim.opt.diff:get() then
      vim.cmd [[normal! [c]]
    else
      vim.cmd [[m .-2<CR>==]]
    end
  end,
}

nmap {
  "<leader>t",
  function()
    if vim.bo.filetype == "lua" then
      return "<Plug>PlenaryTestFile"
    elseif vim.bo.filetype == "go" then
      print "We doing go stuffs"
      return ""
    end
  end,
  { expr = true },
}

local markdown_paste = function(link)
  link = link or vim.fn.getreg "+"

  if not vim.startswith(link, "https://") then
    return
  end

  local request = curl.get(link)
  if not request.status == 200 then
    print "Failed to get link"
    return
  end

  local html_parser = vim.treesitter.get_string_parser(request.body, "html")
  if not html_parser then
    print "Must have html parser installed"
    return
  end

  local tree = (html_parser:parse() or {})[1]
  if not tree then
    print "Failed to parse tree"
    return
  end

  local query = vim.treesitter.parse_query(
    "html",
    [[
      (
       (element
        (start_tag
         (tag_name) @tag)
        (text) @text
       )

       (#eq? @tag "title")
      )
    ]]
  )

  for id, node in query:iter_captures(tree:root(), request.body, 0, -1) do
    local name = query.captures[id]
    if name == "text" then
      local title = vim.treesitter.get_node_text(node, request.body)
      vim.api.nvim_input(string.format("a[%s](%s)", title, link))
      return
    end
  end
end

nmap { "<leader>mdp", markdown_paste }
-- nnoremap { "<space><space>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>" }

-- Switch between tabs
vim.keymap.set("n", "<Right>", function()
  vim.cmd [[checktime]]
  vim.api.nvim_feedkeys("gt", "n", true)
end)

vim.keymap.set("n", "<Left>", function()
  vim.cmd [[checktime]]
  vim.api.nvim_feedkeys("gT", "n", true)
end)
