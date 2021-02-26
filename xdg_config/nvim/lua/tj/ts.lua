local a = vim.api
local ts = vim.treesitter

-- function M.get_parser(bufnr, lang)
--   local buf = bufnr or api.nvim_get_current_buf()
--   local lang = lang or M.get_buf_lang(buf)

--   if M.has_parser(lang) then
--     return ts.get_parser(bufnr, lang)
--   end
-- end

-- function M.attach(bufnr, lang)
--   local parser = parsers.get_parser(bufnr, lang)
--   local config = configs.get_module('highlight')

--   for k, v in pairs(config.custom_captures) do
--     hlmap[k] = v
--   end

--   ts.highlighter.new(parser, {})
-- end

vim.cmd [[augroup CustomTreesitter]]
vim.cmd [[  au!]]
vim.cmd [[  autocmd FileType rust :lua require('tj.ts').rust()]]
vim.cmd [[  autocmd FileType rust :set syntax=]]
vim.cmd [[  autocmd FileType sql :lua require('tj.ts').sql()]]
vim.cmd [[augroup END]]


_CachedHighlighterDetach = _CachedHighlighterDetach or require('nvim-treesitter.highlight').detach
require('nvim-treesitter.highlight').detach = function(bufnr)
  if a.nvim_get_option(bufnr, 'filetype') == 'rust' then
    return
  end

  _CachedHighlighterDetach(bufnr)
end

return {
  rust = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    -- a.nvim_buf_set_option(bufnr, "syntax", "")

    -- vim.schedule(function()
      -- print("Setup:", bufnr)
      local parser = vim.treesitter.get_parser(bufnr, 'rust')

      ts.highlighter.new(parser, {
        queries = {
          rust = table.concat(vim.fn.readfile(
            vim.api.nvim_get_runtime_file('queries/rust/highlights.scm', false)[1]
          ), "\n"),
        }
      })
    -- end)
  end,

  sql = function()
    local parser = vim.treesitter.get_parser(bufnr, 'sql')
    ts.highlighter.new(parser, {})
  end,
}
