nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

let g:grepper = {}

let g:grepper.dir = 'repo,file'
let g:grepper.git = { 'grepprg': 'git grep -nI $* -- `git rev-parse --show-toplevel`' }

" Search for the word under cursor
nnoremap <leader>f :GrepperAg expand('<cword>')<cr>
