scriptencoding utf-8

" General Settings {{{

augroup MyDenite
  au!

  autocmd FileType denite         call s:setup_denite_main()
  autocmd FileType denite-filter  call s:setup_denite_filters()
augroup END


""
" Controls mappings in main denite window
function! s:setup_denite_main() abort
  " Open filter window
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')

  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

""
" Controls mappings while filtering
function! s:setup_denite_filters() abort
  " Quit filter in denite filter window
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
  imap <silent><buffer> <C-c> <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <esc> denite#do_map('quit')
endfunction

call denite#custom#option('default', 'prompt', '>> ')

call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-y>', '<denite:choose_action>', 'noremap')

" Action items
call denite#custom#map('insert', ',p', '<denite:do_action:preview>', 'noremap')
call denite#custom#map('insert', ',v', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('insert', ',s', '<denite:do_action:split>', 'noremap')
call denite#custom#map('insert', ',t', '<denite:do_action:tabopen>', 'noremap')

" Highlighting
call denite#custom#option('default', {
      \ 'highlight_matched_char': 'Underline',
      \ 'highlight_matched_range': 'None',
      \ 'highlight_mode_insert': 'Search',
      \ })

" }}}
" Buffer management {{{
nnoremap <silent> <leader>il :<C-u>Denite line<CR>
nnoremap <silent> <leader>if :<C-u>Denite buffer<CR>
nnoremap <silent> <leader>it :<C-u>Denite tab:no-current<CR>

" Neoyank setup
nnoremap <silent> <leader>iy :<C-u>Denite history/yank<CR>
" }}}
" Menu configuration {{{
let s:menus = {}

let s:menus.init_vim = {
      \ 'description': 'Edit your important init.vim information'
      \ }
let s:menus.init_vim.file_candidates = [
      \ ['nvim/', '~/.config/nvim/'],
      \ ['  init.vim', '~/.config/nvim/init.vim'],
      \ ['  ginit.vim', '~/.config/nvim/ginit.vim'],
      \ ['after/', '~/.config/nvim/after/'],
      \ ['autoload/', '~/.config/nvim/autoload/'],
      \ ['colors/', '~/.config/nvim/colors/'],
      \ ]

call extend(s:menus.init_vim.file_candidates, tj#unite_file_lister(g:_vimrc_base . '/autoload', '  ↳'))

let s:menus.init_vim.file_candidates += [
      \ ['colors/custom_gruvbox', '~/.config/nvim/colors/custom_gruvbox.vim'],
      \ ['init/', '~/.config/nvim/init/'],
      \ ]

call extend(s:menus.init_vim.file_candidates, tj#unite_file_lister(g:_vimrc_base . '/init', '  ↳'))

let s:menus.init_vim.file_candidates += [
      \ ['plugins/', expand(g:plug_home) . '/'],
      \ ]

call extend(
      \ s:menus.init_vim.file_candidates,
      \ map(
          \ items(map(copy(g:plugs), {id, val -> val.dir})),
          \ {idx, val -> ['  ↳ Plug:' . val[0], val[1]]}
          \ ))

let s:menus.init_vim.file_candidates += [
      \ ['scratch/', expand('~/.config/nvim/scratch')],
      \ ]

let s:menus.zsh = {
      \ 'description': 'Edit your import zsh configuration'
      \ }
let s:menus.zsh.file_candidates = [
      \ ['zshrc', '~/.config/zsh/.zshrc'],
      \ ['zshenv', '~/.zshenv'],
      \ ]


let s:zsh_init_config_files = tj#unite_file_lister($ZDOTDIR . '/include', '  ↳', '*.zsh')
call extend(s:menus.zsh.file_candidates, s:zsh_init_config_files)

let s:menus.other = {
      \ 'description': 'Test'
      \ }

let s:menus.other.file_candidates = []

call denite#custom#var('menu', 'menus', s:menus)

" TODO: Figure out the highlighting and other stuff I had in old denite
" Denite menu:init_vim -highlight-mode-insert=Search -highlight-matched-char=Underline -highlight-matched-range=Search

nnoremap <leader>en :Denite menu:init_vim<CR>
nnoremap <leader>ez :Denite menu:zsh<CR>
nnoremap <leader>er :Denite file_mru<CR>

" }}}
" File searching {{{
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

nnoremap <leader>fs :Denite grep:`systemlist('pwd')[0]`<CR>
" }}}
" Grepping {{{
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#var('grep', 'separator', [])
call denite#custom#var('grep', 'default_opts',
        \ [
        \ '--smart-case',
        \ '--nopager', '--nocolor', '--nogroup', '--column',
        \ ])

function! MyDeniteGrep() abort
  let s:cmd = ':Denite grep'

  if tj#buffer_cache('_stl_git_file', 'tj#is_git_file()')
    let s:cmd .= ":`systemlist('git rev-parse --show-toplevel')[0]`"
  endif

  let s:cmd .= "\<CR> \<C-r>\<C-w>\<CR>"
  return s:cmd
endfunction

nnoremap <expr> <leader>fw MyDeniteGrep()
" }}}
" {{{ Wiki stuff
nnoremap ,wp :call execute('Denite file -path=' . g:vimwiki_path . '/projects')<CR>
" }}}

" Neo Yank
if exists('g:neoyank#limit')
  nnoremap <leader>p :Denite neoyank<CR>
endif
" Tags
call denite#custom#source('tag', 'sorters', ['sorter_sublime'])
nnoremap <leader>td :Denite tag:0<CR>

" Neo MRU
let g:neomru#do_validate = 0
let g:neomru#update_interval = 600



" Unite {{{
if g:my_current_uniter ==# 'unite'
  " Quick unite shorcuts
  nnoremap <silent> <leader>il :<C-u>Unite -start-insert line<CR>
  nnoremap <silent> <leader>uf :<C-u>Unite buffer<CR>
  nnoremap <silent> <leader>if :<C-u>Unite -start-insert buffer<CR>
  nnoremap <silent> <leader>ut :<C-u>Unite tab:no-current<CR>
  nnoremap <silent> <leader>it :<C-u>Unite -start-insert tab:no-current<CR>

  " Neoyank setup
  nnoremap <silent> <leader>iy :<C-u>Unite -start-insert history/yank<CR>

  " CtrlP search
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  call unite#filters#sorter_default#use(['sorter_rank'])
  call unite#custom#source('file_rec/async','sorters','sorter_rank')

  " replacing unite with ctrl-p
  nnoremap <silent> <C-p> :Unite -start-insert -buffer-name=files -winheight=10 file_rec/neovim<CR>


  nnoremap <leader>f :Unite grep:.<CR><C-R><C-W><CR>
  nnoremap <silent><buffer><expr> <leader>v unite#do_action('vsplit')


  let g:unite_source_menu_menus = {}
  let g:unite_source_menu_menus.init_vim = {
        \ 'description': 'Edit your important init.vim information'
        \ }
  let g:unite_source_menu_menus.init_vim.file_candidates = [
        \ ['nvim/', '~/.config/nvim/'],
        \ ['  init', '~/.config/nvim/init.vim'],
        \ ['  ginit', '~/.config/nvim/ginit.vim'],
        \ ['after/', '~/.config/nvim/after/'],
        \ ['autoload/', '~/.config/nvim/autoload/'],
        \ ['colors/custom_gruvbox', '~/.config/nvim/colors/custom_gruvbox.vim'],
        \ ['init/', '~/.config/nvim/init/'],
        \ ]

  " Add all the init files that I normally have here.
  let s:init_config_files = tj#unite_file_lister(g:_vimrc_base . '/init', 'i ↳')
  call extend(g:unite_source_menu_menus.init_vim.file_candidates, s:init_config_files)

  let g:unite_source_menu_menus.zsh = {
        \ 'description': 'Edit your import zsh configuration'
        \ }
  let g:unite_source_menu_menus.zsh.file_candidates = [
        \ ['zshrc', '~/.config/zsh/.zshrc'],
        \ ['include', '~/.config/zsh/include/'],
        \ ]
  let s:zsh_init_config_files = tj#unite_file_lister($ZDOTDIR . '/include', '  ↳', '*.zsh')
  call extend(g:unite_source_menu_menus.zsh.file_candidates, s:zsh_init_config_files)

  nnoremap <leader>en :Unite menu:init_vim -start-insert<CR>
  nnoremap <leader>ez :Unite menu:zsh -start-insert<CR>

  " WIP
  let g:unite_source_menu_menus.unite = {
        \     'description' : 'Start unite sources',
        \ }
  let g:unite_source_menu_menus.unite.command_candidates = {
        \       'history'    : 'Unite history/command',
        \       'quickfix'   : 'Unite qflist -no-quit',
        \       'resume'     : 'Unite -buffer-name=resume resume',
        \       'directory'  : 'Unite -buffer-name=files '.
        \             '-default-action=lcd directory_mru',
        \       'mapping'    : 'Unite mapping',
        \       'message'    : 'Unite output:message',
        \       'scriptnames': 'Unite output:scriptnames',
        \     }
endif
" }}}
