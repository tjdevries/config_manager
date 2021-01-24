vim.lsp.handlers["textDocument/definition"] = function(_, _, result)
  if not result or vim.tbl_isempty(result) then
    print("[LSP] Could not find definition")
    return
  end

  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1])
  else
    vim.lsp.util.jump_to_location(result)
  end
end
