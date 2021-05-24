vim.opt.completeopt = { "menuone", "noselect" }

-- Don't show the dumb matching stuff.
vim.cmd [[set shortmess+=c]]

-- Complextras.nvim configuration
vim.api.nvim_set_keymap(
  "i",
  "<C-x><C-m>",
  [[<c-r>=luaeval("require('complextras').complete_matching_line()")<CR>]],
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<C-x><C-d>",
  [[<c-r>=luaeval("require('complextras').complete_line_from_cwd()")<CR>]],
  { noremap = true }
)

local has_compe, compe = pcall(require, "compe")
if has_compe then
  compe.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 200,
    source_timeout = 200,
    incomplete_delay = 400,
    allow_prefix_unmatch = false,

    source = {
      path = true,
      buffer = true,
      calc = false,
      vsnip = true,
      nvim_lsp = true,
      nvim_lua = true,
      spell = true,
      tags = true,
      treesitter = false,
      snippets_nvim = true,
    },
  }

  vim.api.nvim_set_keymap("i", "<c-y>", 'compe#confirm("<c-y>")', { silent = true, noremap = true, expr = true })
  vim.api.nvim_set_keymap("i", "<c-e>", 'compe#close("<c-e>")', { silent = true, noremap = true, expr = true })
  vim.api.nvim_set_keymap("i", "<c-space>", "compe#complete()", { silent = true, noremap = true, expr = true })
end

local has_completion = pcall(require, "completion")
if has_completion then
  -- completion.nvim
  vim.g.completion_confirm_key = ""
  vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }
  vim.g.completion_enable_snippet = "snippets.nvim"

  -- Decide on length
  vim.g.completion_trigger_keyword_length = 2

  -- vim.g.completion_chain_complete_list = {
  --   default = {
  --     {
  --       {complete_items = {'lsp', 'snippet'}},
  --       {complete_items = {'buffer'}}, {mode = 'file'}
  --     }
  --   }
  -- }
end
