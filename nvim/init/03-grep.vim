nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

let g:grepper = {}
let g:grepper.git = { 'grepprg': 'git grep -nI $* -- `git rev-parse --show-toplevel`' }

" Search for the word under cursor
nnoremap <leader>f :Grepper -tool git -open -switch -cword -noprompt<cr>
