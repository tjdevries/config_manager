return {
  {
    "sourcegraph/sg.nvim",
    dev = true,
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    build = "cargo build --workspace",
  },
}
