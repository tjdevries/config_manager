local options = vim.api.nvim_get_all_options_info()

local both = {}
for _, opt in pairs(options) do
  if opt.commalist and opt.flaglist then
    table.insert(both, opt)
  end
end

P(both)
