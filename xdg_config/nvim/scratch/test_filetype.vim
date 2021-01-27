augroup NativeLuaAutocmds
  au!
  autocmd Filetype * :lua require('tj.ft').do_filetype(vim.fn.expand("<amatch>"))
augroup END
