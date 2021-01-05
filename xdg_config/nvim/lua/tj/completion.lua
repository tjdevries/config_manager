
local opt = vim.opt

opt.completeopt = { "menuone" , "noinsert", "noselect" }


-- Don't show the dumb matching stuff.
vim.cmd [[set shortmess+=c]]


-- completion.nvim
vim.g.completion_confirm_key = ""
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
vim.g.completion_enable_snippet = 'snippets.nvim'

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

vim.cmd [[inoremap <c-x><c-m> <c-r>=luaeval("require('complextras').complete_matching_line()")<CR>]]
vim.cmd [[inoremap <c-x><c-d> <c-r>=luaeval("require('complextras').complete_line_from_cwd()")<CR>]]
