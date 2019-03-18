" Neovim specific configuration file

" Thanks to @tweekmonster for thinking of this.
" I've provided some modifications.

let g:_vimrc_base = expand('<sfile>:p:h')
let g:_vimrc_plugins = g:_vimrc_base.'/plugins'
let g:_vimrc_init = isdirectory(g:_vimrc_plugins)

let g:_vimrc_sources = get(g:, '_vimrc_sources', {})

if has('unix')
    let g:plugin_path = expand('~/.config/vim_plug')
else
    let g:plugin_path = expand('$HOME') . '\nvim_plug'
endif

" Source all scripts in a directory
" They around found in `g:_vimrc_plugins`
function! s:source(dir) abort
  " Onlysource files that have the `.vim` extension
  for filename in sort(glob(g:_vimrc_base.'/'.a:dir.'/*.vim', 0, 1))
    let mtime = getftime(filename)
    if !has_key(g:_vimrc_sources, filename) || g:_vimrc_sources[filename] < mtime
      let g:_vimrc_sources[filename] = mtime
      execute 'source '.filename
    endif
  endfor
endfunction

if get(g:, 'gonvim_running', 0)
  execute 'source ' . g:_vimrc_base . '/ginit.vim'
endif

call s:source('init')

" vim:foldmethod=marker:foldlevel=0
