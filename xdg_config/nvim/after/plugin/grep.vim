nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

let g:grepper = {}

let g:grepper.dir = 'repo,file'
let g:grepper.git = { 'grepprg': 'git grep -nI $* -- `git rev-parse --show-toplevel`' }

" Search for the word under cursor
nnoremap <leader>f :GrepperAg expand('<cword>')<cr>


" If we've installed rg
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m

  nnoremap <leader>/ :call FlyGrep#open({})<CR>
  nnoremap <leader>l/ :call FlyGrep#open({'dir': expand('%:h')})<CR>
  nnoremap <leader><leader>/ :call FlyGrep#open({'dir': getcwd()})<CR>
end
