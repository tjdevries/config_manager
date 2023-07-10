return {
  "kyazdani42/nvim-web-devicons",

  -- TODO: Conditionally only do this for linux
  {
    "yamatsum/nvim-web-nonicons",
    config = function()
      require("nvim-nonicons").setup {}
    end,
  },
}
