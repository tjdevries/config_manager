if not pcall(require, "go") then
  return
end

require("go").setup {
  verbose = false, -- output loginf in messages

  -- true: will use go.nvim on_attach if true
  -- nil/false do nothing
  -- lsp_diag_hdlr = true, -- hook lsp diag handler
  dap_debug = true, -- set to true to enable dap
  dap_debug_keymap = false, -- set keymaps for debugger
  dap_debug_gui = true, -- set to true to enable dap gui, highly recommand
  dap_debug_vt = true, -- set to true to enable dap virtual text

  -- TODO: Test these out.
  -- goimport = "gofumports", -- goimport command
  -- gofmt = "gofumpt", --gofmt cmd,
  -- max_line_len = 120, -- max line length in goline format
  -- tag_transform = false, -- tag_transfer  check gomodifytags for details
  -- test_template = "", -- default to testify if not set; g:go_nvim_tests_template  check gotests for details
  -- test_template_dir = "", -- default to nil if not set; g:go_nvim_tests_template_dir  check gotests for details
  -- comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. ﳑ       

  -- Disable everything for LSP
  lsp_cfg = false, -- true: apply go.nvim non-default gopls setup
  lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = false, -- if a on_attach function provided:  attach on_attach function to gopls
  gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile", "/var/log/gopls.log" }
}
