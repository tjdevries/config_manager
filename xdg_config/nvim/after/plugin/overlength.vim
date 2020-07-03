""" 
" # Overlength.vim
"
" Overlength.vim is a plugin I wrote that handles suggesting line lengths in a
" less intrusive way than some of the built-in ways that vim provides.
"""

if !get(g:, 'loaded_overlength')
    finish
endif

let overlength#default_overlength = 120
let overlength#default_to_textwidth = 1
let overlength#default_grace_length = 1

" Disable highlighting in markdown.
call overlength#disable_filetypes([
      \ 'markdown',
      \ 'vimwiki',
      \ 'qf',
      \ 'term',
      \ 'html',
      \ 'startify',
      \ 'man',
      \ 'term',
      \ '',
      \ ])
call overlength#set_overlength('text', 80)
call overlength#set_overlength('startify', 0)

call overlength#set_overlength('vim', 140)
call overlength#set_overlength('help', 81)
call overlength#set_overlength('mumps', 180)
call overlength#set_overlength('sql', 200)
call overlength#set_overlength('python', 240)
call overlength#set_overlength('lua', 140)

" Some of my own "made up" filetypes
call overlength#set_overlength('lookitt', 0)
