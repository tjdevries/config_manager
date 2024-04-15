vim.api.nvim_create_user_command("Recording", function()
  -- Probably too busy for a recording
  vim.opt.listchars:remove "eol"

  -- No numbers, less distraction on screen
  vim.opt.relativenumber = false
  vim.opt.number = false

  -- Remove gitsigns from sidebar
  vim.cmd.Gitsigns "toggle_signs"

  -- Disable AI autocomplete, since it gives spoilers!!
  require("sg").setup {
    enable_cody = false,
  }
end, {})
