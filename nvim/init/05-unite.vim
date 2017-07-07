scriptencoding utf-8

let g:unite_source_radio_play_cmd = 'vlc'

if g:my_current_uniter ==# 'unite'
  " Unite {{{
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
  " }}}
else
  " General Settings {{{
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
  nnoremap <silent> <leader>il :<C-u>Denite -mode=insert line<CR>
  nnoremap <silent> <leader>uf :<C-u>Denite buffer<CR>
  nnoremap <silent> <leader>if :<C-u>Denite -mode=insert buffer<CR>
  nnoremap <silent> <leader>ut :<C-u>Denite tab:no-current<CR>
  nnoremap <silent> <leader>it :<C-u>Denite -mode=insert tab:no-current<CR>

  " Neoyank setup
  nnoremap <silent> <leader>iy :<C-u>Denite -mode=insert history/yank<CR>
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

  call extend(s:menus.init_vim.file_candidates, tj#unite_file_lister(expand(g:plug_home), '  ↳ Plug:', '*'))

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

  " Denite menu:init_vim -highlight-mode-insert=Search -highlight-matched-char=Underline -highlight-matched-range=Search
  nnoremap <leader>en :Denite menu:init_vim -mode=insert -highlight-mode-insert=Search<CR>
  nnoremap <leader>ez :Denite menu:zsh -mode=insert -highlight-mode-insert=Search<CR>
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
  " Neo Yank
  if exists('g:neoyank#limit')
    nnoremap <leader>p :Denite neoyank<CR>
  endif
  " {{{ Wiki stuff
  nnoremap ,wp :call execute('Denite file -path=' . g:vimwiki_path . '/projects')<CR>
  " }}}
endif
