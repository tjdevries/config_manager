local func = {}

func.autocmd = function(args)
  local event = args[1]
  local group = args[2]
  local callback = args[3]

  vim.api.nvim_create_autocmd(event, {
    group = group,
    buffer = args[4],
    callback = function()
      callback()
    end,
    once = args.once,
  })
end

return func
