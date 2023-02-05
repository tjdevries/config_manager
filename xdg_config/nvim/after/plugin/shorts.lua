vim.api.nvim_create_user_command("ShortsRecording", function()
  -- Set to same kitty font size every time, can't get this to work quite yet
  -- vim.fn.system "kitty @ set-font-size 20"
  -- vim.fn.jobstart("kitty @ set-font-size 20", { clear_env = false })

  -- Clear my statusline autocmds
  vim.cmd [[autocmd! ExpressLineAutoSetup]]

  vim.opt.tabline = ""
  vim.opt.statusline = ""
  vim.opt.statuscolumn = ""
  vim.opt.signcolumn = "no"

  -- Handle number settings
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false

  vim.opt_local.laststatus = 0
  vim.opt_local.showmode = false
  vim.opt_local.cmdheight = 0
  vim.opt_local.fillchars:append "eob: "

  vim.opt.cursorcolumn = false
  vim.opt_local.cursorcolumn = false
  vim.opt.cursorline = false
  vim.opt_local.cursorline = false

  vim.opt_local.scrolloff = 0

  vim.opt.colorcolumn = "40,41,42,43"

  vim.cmd.LspStop()

  vim.opt.guicursor = "a:blinkon0"
end, {})

-- vim.cmd.ShortsRecording()
