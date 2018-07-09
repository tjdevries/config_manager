function! ChangeSql() abort
    normal! ggGId %zAddLine(.text,"
    normal! %s/$/")$
    normal! %s/d %zAddLine(.text,"")/;
    normal! ggGI    
endfunction

