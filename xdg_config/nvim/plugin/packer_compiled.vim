" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif
try

lua << END
  local package_path_str = "/home/tj/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/tj/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/tj/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/tj/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
  local install_cpath_pattern = "/home/tj/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
  if not string.find(package.path, package_path_str, 1, true) then
    package.path = package.path .. ';' .. package_path_str
  end

  if not string.find(package.cpath, install_cpath_pattern, 1, true) then
    package.cpath = package.cpath .. ';' .. install_cpath_pattern
  end

_G.packer_plugins = {
  ["BetterLua.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/BetterLua.vim"
  },
  ["JavaScript-Indent"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/opt/JavaScript-Indent"
  },
  NrrwRgn = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/NrrwRgn"
  },
  ["Vim-Jinja2-Syntax"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/Vim-Jinja2-Syntax"
  },
  ["ansible-vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/ansible-vim"
  },
  ["any-jump.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/any-jump.vim"
  },
  ["apyrori.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/apyrori.nvim"
  },
  ["architext.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/architext.nvim"
  },
  ["astronauta.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/astronauta.nvim"
  },
  ["bandaid.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/bandaid.nvim"
  },
  ["colorbuddy.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/colorbuddy.vim"
  },
  ["command_and_conquer.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/command_and_conquer.nvim"
  },
  ["committia.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/committia.vim"
  },
  ["completion-nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/completion-nvim"
  },
  ["completion-treesitter"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/completion-treesitter"
  },
  ["complextras.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/complextras.nvim"
  },
  ["conf.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/conf.vim"
  },
  ["contextprint.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/contextprint.nvim"
  },
  ["cyclist.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/cyclist.vim"
  },
  ["dial.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/dial.nvim"
  },
  ["edit_alternate.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/edit_alternate.vim"
  },
  ["emmet-vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  ["exception.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/exception.vim"
  },
  ["express_line.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/express_line.nvim"
  },
  ["far.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/far.vim"
  },
  firenvim = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/firenvim"
  },
  ["fold_search.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/fold_search.vim"
  },
  fzf = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["gina.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/gina.vim"
  },
  ["git-messenger.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/git-messenger.vim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/goyo.vim"
  },
  ["gruvbuddy.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/gruvbuddy.nvim"
  },
  ["gundo.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/gundo.vim"
  },
  ["haskell-vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/haskell-vim"
  },
  ["haunted.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/haunted.vim"
  },
  ["javascript-libraries-syntax.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/javascript-libraries-syntax.vim"
  },
  ["jupyter_ascending.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/jupyter_ascending.vim"
  },
  ["limelight.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/limelight.vim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["manillua.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/manillua.nvim"
  },
  ["neuron.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/neuron.vim"
  },
  ["nlua.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nlua.nvim"
  },
  ["nsync.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nsync.nvim"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-dap-python"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-dap-python"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-luadev"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-luadev"
  },
  ["nvim-terminal.lua"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-terminal.lua"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["octo.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/octo.nvim"
  },
  ["overlength.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/overlength.vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["pastery.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/pastery.vim"
  },
  playground = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["py_package.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/py_package.nvim"
  },
  ["pytest.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/pytest.vim"
  },
  ["sideways.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/sideways.vim"
  },
  ["snippets.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/snippets.nvim"
  },
  ["spellrotate.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/spellrotate.vim"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/splitjoin.vim"
  },
  ["sql.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/sql.nvim"
  },
  ["standard.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/standard.vim"
  },
  ["streamer.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/streamer.nvim"
  },
  ["tabline.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/tabline.vim"
  },
  tabular = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/tabular"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim"
  },
  ["telescope-fzf-writer.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope-fzf-writer.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope-github.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope-github.nvim"
  },
  ["telescope-packer.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope-packer.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["train.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/train.vim"
  },
  ["tree-sitter-lua"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/tree-sitter-lua"
  },
  ["typescript-vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/typescript-vim"
  },
  ["ui.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/ui.nvim"
  },
  ["vader.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vader.vim"
  },
  ["vim-abolish"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-apm"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-apm"
  },
  ["vim-be-good"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-be-good"
  },
  ["vim-boxdraw"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-boxdraw"
  },
  ["vim-characterize"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-characterize"
  },
  ["vim-clang-format"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-clang-format"
  },
  ["vim-commentary"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-devicons"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-dirvish"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-dispatch"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-dispatch"
  },
  ["vim-godot"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-godot"
  },
  ["vim-inyoface"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-inyoface"
  },
  ["vim-javascript"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/opt/vim-javascript"
  },
  ["vim-javascript-syntax"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-javascript-syntax"
  },
  ["vim-json"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-json"
  },
  ["vim-jsx-typescript"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-jsx-typescript"
  },
  ["vim-liquid"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-liquid"
  },
  ["vim-metarepeat"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-metarepeat"
  },
  ["vim-mscgen"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-mscgen"
  },
  ["vim-prettier"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-prettier"
  },
  ["vim-projectionist"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-projectionist"
  },
  ["vim-ps1"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-ps1"
  },
  ["vim-qf"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-qf"
  },
  ["vim-repeat"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-scriptease"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-scriptease"
  },
  ["vim-searchindex"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-searchindex"
  },
  ["vim-signit"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-signit"
  },
  ["vim-startify"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-startuptime"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-startuptime"
  },
  ["vim-surround"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-syntax-extra"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-syntax-extra"
  },
  ["vim-textobj-python"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-textobj-python"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  },
  ["vim-toml"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-toml"
  },
  vim9jit = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim9jit"
  },
  ["vista.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vista.vim"
  },
  ["vlog.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vlog.nvim"
  },
  ["wander.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/wander.nvim"
  },
  ["wiki.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/wiki.vim"
  }
}

local function handle_bufread(names)
  for _, name in ipairs(names) do
    local path = packer_plugins[name].path
    for _, dir in ipairs({ 'ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin' }) do
      if #vim.fn.finddir(dir, path) > 0 then
        vim.cmd('doautocmd BufRead')
        return
      end
    end
  end
end

local packer_load = nil
local function handle_after(name, before)
  local plugin = packer_plugins[name]
  plugin.load_after[before] = nil
  if next(plugin.load_after) == nil then
    packer_load({name}, {})
  end
end

packer_load = function(names, cause)
  local some_unloaded = false
  for _, name in ipairs(names) do
    if not packer_plugins[name].loaded then
      some_unloaded = true
      break
    end
  end

  if not some_unloaded then return end

  local fmt = string.format
  local del_cmds = {}
  local del_maps = {}
  for _, name in ipairs(names) do
    if packer_plugins[name].commands then
      for _, cmd in ipairs(packer_plugins[name].commands) do
        del_cmds[cmd] = true
      end
    end

    if packer_plugins[name].keys then
      for _, key in ipairs(packer_plugins[name].keys) do
        del_maps[key] = true
      end
    end
  end

  for cmd, _ in pairs(del_cmds) do
    vim.cmd('silent! delcommand ' .. cmd)
  end

  for key, _ in pairs(del_maps) do
    vim.cmd(fmt('silent! %sunmap %s', key[1], key[2]))
  end

  for _, name in ipairs(names) do
    if not packer_plugins[name].loaded then
      vim.cmd('packadd ' .. name)
      if packer_plugins[name].config then
        for _i, config_line in ipairs(packer_plugins[name].config) do
          loadstring(config_line)()
        end
      end

      if packer_plugins[name].after then
        for _, after_name in ipairs(packer_plugins[name].after) do
          handle_after(after_name, name)
          vim.cmd('redraw')
        end
      end

      packer_plugins[name].loaded = true
    end
  end

  handle_bufread(names)

  if cause.cmd then
    local lines = cause.l1 == cause.l2 and '' or (cause.l1 .. ',' .. cause.l2)
    vim.cmd(fmt('%s%s%s %s', lines, cause.cmd, cause.bang, cause.args))
  elseif cause.keys then
    local keys = cause.keys
    local extra = ''
    while true do
      local c = vim.fn.getchar(0)
      if c == 0 then break end
      extra = extra .. vim.fn.nr2char(c)
    end

    if cause.prefix then
      local prefix = vim.v.count ~= 0 and vim.v.count or ''
      prefix = prefix .. '"' .. vim.v.register .. cause.prefix
      if vim.fn.mode('full') == 'no' then
        if vim.v.operator == 'c' then
          prefix = '' .. prefix
        end

        prefix = prefix .. vim.v.operator
      end

      vim.fn.feedkeys(prefix, 'n')
    end

    local escaped_keys = vim.api.nvim_replace_termcodes(cause.keys .. extra, true, true, true)
    vim.api.nvim_feedkeys(escaped_keys, 'm', true)
  elseif cause.event then
    vim.cmd(fmt('doautocmd <nomodeline> %s', cause.event))
  elseif cause.ft then
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeplugin', cause.ft))
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeindent', cause.ft))
  end
end

_packer_load_wrapper = function(names, cause)
  success, err_msg = pcall(packer_load, names, cause)
  if not success then
    vim.cmd('echohl ErrorMsg')
    vim.cmd('echomsg "Error in packer_compiled: ' .. vim.fn.escape(err_msg, '"') .. '"')
    vim.cmd('echomsg "Please check your config for correctness"')
    vim.cmd('echohl None')
  end
end

-- Runtimepath customization

-- Pre-load configuration
-- Post-load configuration
-- Conditional loads
-- Load plugins in order defined by `after`
END

function! s:load(names, cause) abort
  call luaeval('_packer_load_wrapper(_A[1], _A[2])', [a:names, a:cause])
endfunction


" Command lazy-loads

" Keymap lazy-loads

augroup packer_load_aucmds
  au!
  " Filetype lazy-loads
  au FileType html ++once call s:load(['vim-javascript'], { "ft": "html" })
  au FileType javascript ++once call s:load(['JavaScript-Indent', 'vim-javascript'], { "ft": "javascript" })
  " Event lazy-loads
  " Function lazy-loads
augroup END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
