if $IS_SSH
  augroup SSH_AUTO
    au!
    autocmd BufReadPost * set norelativenumber
    autocmd BufReadPost * set nonumber
  augroup END
endif
