
setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

setlocal norelativenumber

" abbreviate <buffer> select SELECT
" abbreviate <buffer> from FROM

" abbreviate <buffer> when WHEN
" abbreviate <buffer> then THEN
" abbreviate <buffer> else ELSE
" abbreviate <buffer> end END

inoremap <buffer> ,,<CR> <C-O>:call <SID>string_newline()<CR> 

function! s:string_newline() abort
  let current_line = getline('.')
  let num_spaces = len(matchstr(current_line, '\(\s*\)N''')) - 2

  call execute(printf("normal! i\<space>'\<CR>+%sN'", repeat("\<space>", num_spaces)))
endfunction

" Cool substitutions:
"
" Use this to change the results of this query:
"
" SELECT
"     c.name 'Column Name',
"     t.Name 'Data type',
"     c.max_length 'Max Length',
"     c.precision ,
"     c.scale ,
"     c.is_nullable,
"     ISNULL(i.is_primary_key, 0) 'Primary Key'
" FROM
"     sys.columns c
" INNER JOIN
"     sys.types t ON c.user_type_id = t.user_type_id
" LEFT OUTER JOIN
"     sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
" LEFT OUTER JOIN
"     sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
" WHERE
"     c.object_id = OBJECT_ID('[Epic].[ClaimsDatalinkDatamart]')
"
" Into a table definition:
"
" %s/\(\w*\)\t\(\w*\)\t\(.*\)/\=submatch(1) . ' ' . submatch(2) . ( submatch(2) == 'nvarchar' && submatch(3) != '-1' ? '(' . submatch(3) . ')' : '') . ','
