set tags=tags; " Enable ctags

if g:my_tags_manager == 'gutentags'
    " No config
elseif g:my_tags_manager == 'vim-tags'
    " No config
elseif g:my_tags_manager == 'easytags'
    let g:easytags_file = '~/.cache/tags'
    let g:easytags_async = 1    " Background support for easy tags
    let g:easytags_event = ['BufWritePost'] " Update the tags after writing
else
    echoerr "You've set your tags manager to something new"
endif
