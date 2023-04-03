return {
  "rktjmp/hotpot.nvim",
  "Olical/aniseed",
  -- { "eraserhd/parinfer-rust", build = "cargo build --release" },
  {
    "gpanders/nvim-parinfer",
    config = function()
      vim.g.parinfer_force_balance = true
      vim.g.parinfer_filetypes = {
        -- Mine
        "query",
        "dune",
        -- Defaults
        "clojure",
        "scheme",
        "lisp",
        "racket",
        "hy",
        "fennel",
        "janet",
        "carp",
        "wast",
        "yuck",
      }
    end,
  },
}
