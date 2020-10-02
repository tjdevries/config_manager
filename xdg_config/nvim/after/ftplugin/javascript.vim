augroup MyJavascriptCommands
  au!
  " autocmd BufWritePost *.js :silent! !prettier --write %
  autocmd BufWritePost *.js :silent! Prettier
augroup END
