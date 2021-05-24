vim.cmd [[packadd vimball]]

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_wsl = (function()
  local output = vim.fn.systemlist "uname -r"
  return not not string.find(output[1] or "", "WSL")
end)()

return require("packer").startup {
  function(use)
    use "wbthomason/packer.nvim"

    local local_use = function(first, second)
      local plug_path, home
      if second == nil then
        plug_path = first
        home = "tjdevries"
      else
        plug_path = second
        home = first
      end

      if vim.fn.isdirectory(vim.fn.expand("~/plugins/" .. plug_path)) == 1 then
        use("~/plugins/" .. plug_path)
      else
        use(string.format("%s/%s", home, plug_path))
      end
    end

    -- My Plugins
    local_use "nlua.nvim"
    local_use "vim9jit"
    local_use "colorbuddy.nvim"
    local_use "gruvbuddy.nvim"
    local_use "apyrori.nvim"
    local_use "manillua.nvim"
    local_use "cyclist.vim"
    local_use "express_line.nvim"
    local_use "overlength.vim"
    local_use "pastery.vim"
    local_use "complextras.nvim"
    local_use "astronauta.nvim"

    -- When I have some extra time...
    local_use "train.vim"
    local_use "command_and_conquer.nvim"
    local_use "streamer.nvim"
    local_use "bandaid.nvim"

    local_use "nsync.nvim"
    use "bfredl/nvim-luadev"

    -- LSP Plugins:

    -- NOTE: lspconfig ONLY has configs, for people reading this :)
    use "neovim/nvim-lspconfig"
    use "wbthomason/lsp-status.nvim"

    local_use "lsp_extensions.nvim"
    use "glepnir/lspsaga.nvim"
    use "onsails/lspkind-nvim"

    use { "akinsho/flutter-tools.nvim" }

    use {
      "folke/lsp-trouble.nvim",
      config = function()
        -- Can use P to toggle auto movement
        require("trouble").setup {
          auto_preview = false,
          auto_fold = true,
        }
      end,
    }

    -- TODO: Investigate
    -- use 'jose-elias-alvarez/nvim-lsp-ts-utils'

    local_use("nvim-lua", "popup.nvim")
    local_use("nvim-lua", "plenary.nvim")

    local_use("nvim-telescope", "telescope.nvim")
    local_use("nvim-telescope", "telescope-fzf-writer.nvim")
    local_use("nvim-telescope", "telescope-packer.nvim")
    local_use("nvim-telescope", "telescope-async-sorter-test.nvim")
    local_use("nvim-telescope", "telescope-fzy-native.nvim")
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    local_use("nvim-telescope", "telescope-github.nvim")
    local_use("nvim-telescope", "telescope-symbols.nvim")

    local_use "telescope-hacks.nvim"
    local_use "telescope-sourcegraph.nvim"
    local_use "green_light.nvim"

    use "tami5/sql.nvim"
    use "nvim-telescope/telescope-frecency.nvim"
    use "nvim-telescope/telescope-cheat.nvim"
    use { "nvim-telescope/telescope-arecibo.nvim", rocks = { "openssl", "lua-http-parser" } }

    use {
      "antoinemadec/FixCursorHold.nvim",
      run = function()
        vim.g.curshold_updatime = 1000
      end,
    }

    use "nanotee/luv-vimdocs"

    -- PRACTICE: {{{
    use "tpope/vim-projectionist" -- STREAM: Alternate file editting and some helpful stuff

    -- For narrowing regions of text to look at them alone
    use "chrisbra/NrrwRgn" -- Figure out some good ways to use this on stream

    use "tweekmonster/spellrotate.vim"
    use "haya14busa/vim-metarepeat" -- Never figured out how to use this, but looks like fun.
    -- }}}
    -- VIM EDITOR: {{{

    -- Little know features:
    --   :SSave
    --   :SLoad
    --       These are wrappers for mksession that work great. I never have to use
    --       mksession anymore or worry about where things are saved / loaded from.
    use "mhinz/vim-startify"

    -- Better profiling output for startup.
    use "dstein64/vim-startuptime"
    -- use 'tweekmonster/startuptime.vim'  -- Might switch back to this, but they are incompatible.

    -- Pretty colors
    use "norcalli/nvim-colorizer.lua"
    use "norcalli/nvim-terminal.lua"

    -- Make comments appear IN YO FACE
    use "tjdevries/vim-inyoface"

    -- Show only what you're searching for.
    -- STREAM: Could probably make this a bit better. Definitely needs docs
    use "tjdevries/fold_search.vim"

    use "tweekmonster/exception.vim"
    use "tweekmonster/haunted.vim"

    -- :Messages <- view messages in quickfix list
    -- :Verbose  <- view verbose output in preview window.
    -- :Time     <- measure how long it takes to run some stuff.
    use "tpope/vim-scriptease"

    -- Quickfix enhancements. See :help vim-qf
    use "romainl/vim-qf"

    use {
      "glacambre/firenvim",
      run = function()
        vim.fn["firenvim#install"](0)
      end,
    }

    -- TODO: Eventually statusline should consume this.
    use "mkitt/tabline.vim"

    use "kyazdani42/nvim-web-devicons"
    if not is_wsl then
      use "yamatsum/nvim-web-nonicons"
    end

    -- use { 'Shougo/defx.nvim', }
    use "kyazdani42/nvim-tree.lua"
    use "lambdalisue/vim-protocol"

    -- Undo helper
    use "sjl/gundo.vim"

    -- TODO: This randomly disappeared? Find a replacement sometime.
    -- Make cool signs for your files
    -- use 'johannesthyssen/vim-signit'

    -- Crazy good box drawing
    use "gyim/vim-boxdraw"

    -- Better increment/decrement
    use "monaqa/dial.nvim"

    --   FOCUSING: {{{
    use "junegunn/goyo.vim"
    use "junegunn/limelight.vim"
    --   }}}
    -- }}}
    --  LANGUAGE: {{{
    -- TODO: Should check on these if they are the best ones
    use "neovimhaskell/haskell-vim"
    use "justinmk/vim-syntax-extra"
    use "elzr/vim-json"
    use "goodell/vim-mscgen"
    use "pearofducks/ansible-vim"
    use "PProvost/vim-ps1"
    use "cespare/vim-toml"
    use "Glench/Vim-Jinja2-Syntax"

    use "ziglang/zig.vim"

    -- Can add back if we ever use it.
    -- use 'JuliaEditorSupport/julia-vim'

    use { "iamcco/markdown-preview.nvim", run = "cd app && yarn install" }

    -- Typescript {{{
    -- TODO: Should probably only load these when necessary.
    -- TODO: Should prboably check if these work for typescript, typescript.tsx, etc.
    use "jelera/vim-javascript-syntax"
    use "othree/javascript-libraries-syntax.vim"
    use "leafgarland/typescript-vim"
    use "peitalin/vim-jsx-typescript"

    -- Wonder if I can make LSP do this and respect .prettier files.
    --  I don't write enough typescript to think about this.
    use { "prettier/vim-prettier", run = "yarn install" }

    -- TODO: Turn emmet back on when I someday use it
    -- use 'mattn/emmet-vim'

    use { "vim-scripts/JavaScript-Indent", ft = "javascript" }
    use { "pangloss/vim-javascript", ft = { "javascript", "html" } }
    use "tpope/vim-liquid"
    -- }}}
    -- Godot {{{
    use "habamax/vim-godot"
    -- }}}
    -- Lisp {{{
    -- use { 'eraserhd/parinfer-rust', run = 'cargo build --release' }
    -- }}}
    --  }}}
    -- LSP {{{

    -- STREAM: Figure out how to use snippets better
    -- use 'haorenW1025/completion-nvim'
    use "hrsh7th/nvim-compe"

    -- Completion stuff
    local_use "rofl.nvim"

    use "hrsh7th/vim-vsnip"
    use "hrsh7th/vim-vsnip-integ"
    -- use 'norcalli/snippets.nvim'

    -- Cool tags based viewer
    --   :Vista  <-- Opens up a really cool sidebar with info about file.
    use "liuchengxu/vista.vim"

    -- Find and replace
    use {
      "brooth/far.vim",

      cond = function()
        return vim.fn.has "python3" == 1
      end,
    }

    -- Debug adapter protocol
    --   Have not yet checked this out, but looks awesome.
    -- use 'puremourning/vimspector'
    use "mfussenegger/nvim-dap"
    use "theHamsta/nvim-dap-virtual-text"
    use "mfussenegger/nvim-dap-python"
    use "nvim-telescope/telescope-dap.nvim"

    use "jbyuki/one-small-step-for-vimkind"

    if has "python3" then
      use {
        "rcarriga/vim-ultest",

        requires = { "vim-test/vim-test" },
        run = ":UpdateRemotePlugins",
        cond = function()
          return vim.fn.has "python3" == 1
        end,
        config = function()
          vim.cmd [[nmap ]t <Plug>(ultest-next-fail)]]
          vim.cmd [[nmap [t <Plug>(ultest-prev-fail)]]
        end,
      }

      use "alfredodeza/pytest.vim"
    end

    if false and has "python3" then
      use "puremourning/vimspector"
    end
    -- }}}

    -- TREE SITTER: {{{
    local_use("nvim-treesitter", "nvim-treesitter")
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-treesitter/playground"
    use "vigoux/architext.nvim"

    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Grammars
    local_use "tree-sitter-lua"
    local_use "tree-sitter-sql"

    -- }}}
    -- NAVIGATION: {{{
    -- STREAM: Show off edit_alternate.vim
    use "tjdevries/edit_alternate.vim"

    use "google/vim-searchindex"

    -- use 'justinmk/vim-dirvish'
    use "tamago324/lir.nvim"

    use "pechorin/any-jump.vim"

    -- Temporary disabled... getting real bad performance in some lua files.
    --  Might just disable for Lua only?...
    -- use 'andymass/vim-matchup'

    -- }}}
    -- TEXT MANIUPLATION {{{
    use "godlygeek/tabular" -- Quickly align text by pattern
    use "tpope/vim-commentary" -- Easily comment out lines or objects
    use "tpope/vim-repeat" -- Repeat actions better
    use "tpope/vim-abolish" -- Cool things with words!
    use "tpope/vim-characterize"
    use "tpope/vim-dispatch"
    use "AndrewRadev/splitjoin.vim"
    -- use 'AndrewRadev/sideways.vim' -- Easy sideways movement

    -- TODO: Check out macvhakann/vim-sandwich at some point
    use "tpope/vim-surround" -- Surround text objects easily

    -- Do I even use any of these?
    use "kana/vim-textobj-user"
    use "bps/vim-textobj-python"
    -- }}}
    -- Python: {{{

    -- }}}
    -- GIT: {{{
    -- gita replacement
    -- use 'lambdalisue/gina.vim'
    use "TimUntersberger/neogit"

    -- Github integration
    if vim.fn.executable "gh" == 1 then
      use "pwntester/octo.nvim"
    end
    use "ruifm/gitlinker.nvim"

    -- Sweet message committer
    use "rhysd/committia.vim"

    -- Floating windows are awesome :)
    use "rhysd/git-messenger.vim"

    -- Async signs!
    if has "nvim-0.5" then
      -- use 'lewis6991/gitsigns.nvim'
    end

    -- }}}

    -- use 'untitled-ai/jupyter_ascending.vim'

    use "tjdevries/standard.vim"
    use "tjdevries/conf.vim"
    use "junegunn/vader.vim"

    use { "junegunn/fzf", run = "./install --all" } -- Fuzzy Searcher
    use { "junegunn/fzf.vim" }
    -- use {'yuki-ycino/fzf-preview.vim', run = 'yarn global add' }
    -- use {'yuki-ycino/fzf-preview.vim', run = 'npm install' }

    use "lervag/wiki.vim"
    use "ihsanturk/neuron.vim"

    -- use 'ThePrimeagen/vim-apm'
    -- use 'ThePrimeagen/vim-be-good'

    use "alec-gibson/nvim-tetris"

    -- WIP:
    local_use "py_package.nvim"

    -- TODO: Figure out why this randomly popups
    --       Figure out if I want to use it later as well :)
    -- use {
    --   'folke/which-key.nvim',
    --   config = function()
    --     -- TODO: Consider changing my timeoutlen?
    --     require('which-key').setup {
    --       presets = {
    --         g = true,
    --       },
    --     }
    --   end,
    -- }

    -- It would be fun to think about making a wiki again...
    -- local_use 'wander.nvim'
    -- local_use 'riki.nvim'

    -- pretty sure I'm done w/ these
    -- local_use 'vlog.nvim'
  end,
  config = {
    display = {
      -- open_fn = require('packer.util').float,
    },
  },
}

--[[ Replacements Needed
" Plug 'https://github.com/AndrewRadev/linediff.vim'
" Plug 'https://github.com/AndrewRadev/switch.vim'

Plu 'plasticboy/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = [
\ 'python=python',
\ 'json=json',
\ ]

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

-- Should get a test helper.
Plug 'alfredodeza/pytest.vim'

-- completes issue names in commit messages
Plug 'tpope/vim-rhubarb'

-- Create menus easily.
Plug 'skywind3000/quickmenu.vim'

-- Indentation guides
Plug 'nathanaelkane/vim-indent-guides'                       " See indentation guides

--]]
