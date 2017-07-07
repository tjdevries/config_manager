let overlength#default_overlength = 120
let overlength#default_to_textwidth = 1

" Disable highlighting in markdown.
call overlength#set_overlength('markdown', 0)
call overlength#set_overlength('vimwiki', 0)
call overlength#set_overlength('text', 0)

" Highlight only at 120 characters in vim, even though textwidth = 78
call overlength#set_overlength('vim', 120)
call overlength#set_overlength('help', 81)
