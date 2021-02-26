" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

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

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["JavaScript-Indent"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/tj/.local/share/nvim/site/pack/packer/opt/JavaScript-Indent"
  },
  NrrwRgn = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/NrrwRgn"
  },
  ["Vim-Jinja2-Syntax"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/Vim-Jinja2-Syntax"
  },
  ["ansible-vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/ansible-vim"
  },
  ["any-jump.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/any-jump.vim"
  },
  ["apyrori.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/apyrori.nvim"
  },
  ["architext.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/architext.nvim"
  },
  ["astronauta.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/astronauta.nvim"
  },
  ["bandaid.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/bandaid.nvim"
  },
  ["colorbuddy.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/colorbuddy.vim"
  },
  ["command_and_conquer.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/command_and_conquer.nvim"
  },
  ["committia.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/committia.vim"
  },
  ["completion-treesitter"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/completion-treesitter"
  },
  ["complextras.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/complextras.nvim"
  },
  ["conf.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/conf.vim"
  },
  ["cyclist.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/cyclist.vim"
  },
  ["dial.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/dial.nvim"
  },
  ["edit_alternate.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/edit_alternate.vim"
  },
  ["exception.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/exception.vim"
  },
  ["express_line.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/express_line.nvim"
  },
  ["far.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/far.vim"
  },
  firenvim = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/firenvim"
  },
  ["fold_search.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/fold_search.vim"
  },
  fzf = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["gina.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/gina.vim"
  },
  ["git-messenger.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/git-messenger.vim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/goyo.vim"
  },
  ["green_light.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/green_light.nvim"
  },
  ["gruvbuddy.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/gruvbuddy.nvim"
  },
  ["gundo.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/gundo.vim"
  },
  ["haskell-vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/haskell-vim"
  },
  ["haunted.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/haunted.vim"
  },
  ["javascript-libraries-syntax.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/javascript-libraries-syntax.vim"
  },
  ["jupyter_ascending.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/jupyter_ascending.vim"
  },
  ["limelight.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/limelight.vim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["manillua.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/manillua.nvim"
  },
  ["neuron.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/neuron.vim"
  },
  ["nlua.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nlua.nvim"
  },
  ["nsync.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nsync.nvim"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-dap-python"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-dap-python"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-luadev"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-luadev"
  },
  ["nvim-terminal.lua"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-terminal.lua"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["octo.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/octo.nvim"
  },
  ["overlength.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/overlength.vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["pastery.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/pastery.vim"
  },
  playground = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["py_package.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/py_package.nvim"
  },
  ["pytest.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/pytest.vim"
  },
  ["rofl.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/rofl.nvim"
  },
  ["sideways.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/sideways.vim"
  },
  ["snippets.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/snippets.nvim"
  },
  ["spellrotate.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/spellrotate.vim"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/splitjoin.vim"
  },
  ["sql.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/sql.nvim"
  },
  ["standard.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/standard.vim"
  },
  ["streamer.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/streamer.nvim"
  },
  ["tabline.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/tabline.vim"
  },
  tabular = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/tabular"
  },
  ["telescope-cheat.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope-cheat.nvim"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim"
  },
  ["telescope-fzf-writer.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope-fzf-writer.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope-github.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope-github.nvim"
  },
  ["telescope-hacks.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope-hacks.nvim"
  },
  ["telescope-packer.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope-packer.nvim"
  },
  ["telescope-sourcegraph.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope-sourcegraph.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["train.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/train.vim"
  },
  ["tree-sitter-lua"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/tree-sitter-lua"
  },
  ["tree-sitter-sql"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/tree-sitter-sql"
  },
  ["typescript-vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/typescript-vim"
  },
  ["ui.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/ui.nvim"
  },
  ["vader.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vader.vim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-apm"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-apm"
  },
  ["vim-be-good"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-be-good"
  },
  ["vim-boxdraw"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-boxdraw"
  },
  ["vim-characterize"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-characterize"
  },
  ["vim-clang-format"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-clang-format"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-dirvish"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-dispatch"
  },
  ["vim-godot"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-godot"
  },
  ["vim-inyoface"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-inyoface"
  },
  ["vim-javascript"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/opt/vim-javascript"
  },
  ["vim-javascript-syntax"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-javascript-syntax"
  },
  ["vim-json"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-json"
  },
  ["vim-jsx-typescript"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-jsx-typescript"
  },
  ["vim-liquid"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-liquid"
  },
  ["vim-metarepeat"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-metarepeat"
  },
  ["vim-mscgen"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-mscgen"
  },
  ["vim-prettier"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-prettier"
  },
  ["vim-projectionist"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-projectionist"
  },
  ["vim-ps1"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-ps1"
  },
  ["vim-qf"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-qf"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-scriptease"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-scriptease"
  },
  ["vim-searchindex"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-searchindex"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-startuptime"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-startuptime"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-syntax-extra"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-syntax-extra"
  },
  ["vim-textobj-python"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-textobj-python"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim-toml"
  },
  vim9jit = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vim9jit"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vista.vim"
  },
  ["vlog.nvim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/vlog.nvim"
  },
  ["wiki.vim"] = {
    loaded = true,
    path = "/home/tj/.local/share/nvim/site/pack/packer/start/wiki.vim"
  }
}

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'JavaScript-Indent', 'vim-javascript'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'vim-javascript'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
vim.cmd [[source /home/tj/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/flow.vim]]
vim.cmd [[source /home/tj/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/javascript.vim]]
vim.cmd("augroup END")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
