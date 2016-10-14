scriptencoding utf-8


let g:unite_source_radio_play_cmd = 'vlc'


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
                  \ ['after/', '~/.config/nvim/after/'],
                  \ ['autoload/', '~/.config/nvim/autoload/'],
                  \ ['init/', '~/.config/nvim/init/'],
                  \ ['  basic configuration', '~/.config/nvim/init/01-basic_configuration.vim'],
                  \ ['  colorscheme', '~/.config/nvim/init/03-colorscheme.vim'],
                  \ ['  plugins', '~/.config/nvim/init/02-plugins.vim'],
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
