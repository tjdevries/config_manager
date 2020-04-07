let g:startify_bookmarks = [
            \ '~/.zshrc',
            \ '~/.config/nvim/init.vim',
            \ '~/.config/nvim/init/',
            \ ]


if isdirectory('F:\personal\tdevries\')
  call add(g:startify_bookmarks, 'F:/personal/tdevries/work_git')
endif

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
