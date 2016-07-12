let g:startify_bookmarks = ['~/.zshrc', '~/.config/nvim/.nvimrc']
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
