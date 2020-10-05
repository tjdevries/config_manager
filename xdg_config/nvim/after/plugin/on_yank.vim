" Cool highlighting courtesy of @clason
augroup LuaHighlight
  au!
  au TextYankPost * lua vim.highlight.on_yank {
        \ higroup = "Substitute",
        \ timeout = 150,
        \ on_macro = true
        \ }
augroup END
