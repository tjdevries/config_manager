# Things to Read

This file contains things that I consider useful to read. It often contains ideas about large and general things I want to learn more about

## VIM
- http://vimdoc.sourceforge.net/htmldoc/usr_32.html
    - This document is about undo and redo
    - It can send you back in time, send you back to last file save, forward to next file save
    - Examples
        - `:undolist`     See what branches we have in the undo tree
        - `:earlier 10m`  Sends us back in time 10 minutes to what the file looked like then
- http://usevim.com/2012/07/06/vim101-completion/
    - This document teaches about vim auto-completion
    - Area of investigation: `Omni Completion`. Seems able to add programming-language specific completion
    - Examples:
        - `:set complete`                           Shows list of current auto complete options
        - `:set complete+=k`                        Adds dictionary scnanning
        - `:set dictionary=/usr/share/dict/words`   Add a personal dictionary
- http://vim.wikia.com/wiki/Omni_completioni
    - This document talks exclusively about `Omni Completion`
