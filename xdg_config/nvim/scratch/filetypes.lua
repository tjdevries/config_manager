vim.filetype.add {
  extension = {
    arch = function()
      return "arch.linux", function()
        vim.b.relationship = "single"
      end
    end,
  },
}
