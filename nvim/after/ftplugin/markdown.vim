augroup markdown
    " remove buffer-local auto commands forcurrent buffer
    au!
    " hook to run TableFormat when <bar> is entered in insert mode
    au FileType mkd.markdown exec 'inoremap \| \|<C-O>:TableFormat<CR><C-O>f\|<right>'
    " Ctrl+\ will run TableFormat in either mode
    au FileType mkd.markdown exec 'inoremap <C-\> <C-O>:TableFormat<CR>'
    au FileType mkd.markdown exec 'noremap <silent> <C-\> :TableFormat<CR>'

    let g:vim_markdown_folding_disabled = 1
augroup END
