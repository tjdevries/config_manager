" I want the filetype "term" for terminal windows
augroup TermDetect
    au!
    au TermOpen term://*  set filetype=term
augroup END
