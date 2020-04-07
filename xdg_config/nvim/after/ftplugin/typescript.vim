
augroup MyTypescriptCommands
  au!
  autocmd BufWritePost <buffer>  :silent! !prettier --write %
augroup END
