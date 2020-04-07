""" 
" # Overlength.vim
"
" Overlength.vim is a plugin I wrote that handles suggesting line lengths in a
" less intrusive way than some of the built-in ways that vim provides.
"""

let overlength#default_overlength = 120
let overlength#default_to_textwidth = 1
let overlength#default_grace_length = 1

" Disable highlighting in markdown.
call overlength#set_overlength('markdown', 0)
call overlength#set_overlength('vimwiki', 0)
call overlength#set_overlength('text', 80)
call overlength#set_overlength('qf', 0)
call overlength#set_overlength('term', 0)
call overlength#set_overlength('html', 0)
call overlength#set_overlength('startify', 0)

call overlength#set_overlength('vim', 140)
call overlength#set_overlength('help', 81)
call overlength#set_overlength('mumps', 180)
call overlength#set_overlength('sql', 200)
call overlength#set_overlength('python', 240)


call overlength#set_overlength('', 0)

" Some of my own "made up" filetypes
call overlength#set_overlength('lookitt', 0)
