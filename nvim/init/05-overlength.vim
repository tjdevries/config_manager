let overlength#default_overlength = 120
let overlength#default_to_textwidth = 1
let overlength#default_grace_length = 1

" Disable highlighting in markdown.
call overlength#set_overlength('markdown', 0)
call overlength#set_overlength('vimwiki', 0)
call overlength#set_overlength('text', 0)
call overlength#set_overlength('qf', 0)
call overlength#set_overlength('term', 0)

" Highlight only at 120 characters in vim, even though textwidth = 78
call overlength#set_overlength('vim', 120)
call overlength#set_overlength('help', 81)
call overlength#set_overlength('mumps', 180)


call overlength#set_overlength('', 0)

" Some of my own "made up" filetypes
call overlength#set_overlength('lookitt', 0)
