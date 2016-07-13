let g:startify_bookmarks = [
            \ '~/.zshrc',
            \ '~/.config/nvim/init.vim',
            \ '~/.config/nvim/init/',
            \ '~/.config/nvim/init/00-todo.vim',
            \ '~/.config/nvim/init/01-basic_configuration.vim',
            \ '~/.config/nvim/init/02-plugins.vim',
            \ ]
let g:startify_change_to_dir = 1
let g:startify_list_order = [
  \ ['   LRU:'],
  \ 'files',
  \ ['   LRU within this dir:'],
  \ 'dir',
  \ ['   Sessions:'],
  \ 'sessions',
  \ ['   Bookmarks:'],
  \ 'bookmarks',
  \ ]

let g:startify_skiplist = [
            \ 'COMMIT_EDITMSG',
            \ 'bundle/.*/doc',
            \ '/data/repo/neovim/runtime/doc',
            \ '/Users/mhi/local/vim/share/vim/vim74/doc',
            \ ]

let g:startify_custom_footer =
  \ ['', "   Vim is charityware. Please read ':help uganda'.", '']

" hi StartifyBracket ctermfg=240
" hi StartifyFile    ctermfg=147
" hi StartifyFooter  ctermfg=240
" hi StartifyHeader  ctermfg=114
" hi StartifyNumber  ctermfg=215
" hi StartifyPath    ctermfg=245
" hi StartifySlash   ctermfg=240
" hi StartifySpecial ctermfg=240
