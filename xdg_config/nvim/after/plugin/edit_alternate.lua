if not vim.g.loaded_edit_alternate then
  return
end

vim.fn["edit_alternate#rule#add"]("go", function(filename)
  if filename:find "_test.go" then
    return (filename:gsub("_test%.go", ".go"))
  else
    return (filename:gsub("%.go", "_test.go"))
  end
end)
