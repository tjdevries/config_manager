" Neovim specific configuration file

" Thanks to @tweekmonster for thinking of this.

let g:_vimrc_base = '~/.config/nvim'
let g:_vimrc_plugins = g:_vimrc_base.'/plugins'
let g:_vimrc_init = isdirectory(g:_vimrc_plugins)

let g:_vimrc_sources = get(g:, '_vimrc_sources', {})

if has('unix')
    let g:plugin_path = '~/.vim/plugged'
else
    let g:plugin_path = 'C:/neovim/'
endif

" Source all scripts in a directory
function! s:source(dir) abort
  for filename in sort(glob(g:_vimrc_base.'/'.a:dir.'/*.vim', 0, 1))
    " if !g:_vimrc_init && str2nr(fnamemodify(filename, ':t')[:1]) > 3
    "   continue
    " endif

    let mtime = getftime(filename)
    if !has_key(g:_vimrc_sources, filename) || g:_vimrc_sources[filename] < mtime
      let g:_vimrc_sources[filename] = mtime
      execute 'source '.filename
    endif
  endfor
endfunction

call s:source('init')

" vim:foldmethod=marker:foldlevel=0
