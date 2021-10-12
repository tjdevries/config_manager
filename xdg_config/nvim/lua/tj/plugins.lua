vim.cmd [[packadd packer.nvim]]
vim.cmd [[packadd vimball]]

local has = function(x)
  return vim.fn.has(x) == 1
end

local executable = function(x)
  return vim.fn.executable(x) == 1
end

local is_wsl = (function()
  local output = vim.fn.systemlist "uname -r"
  return not not string.find(output[1] or "", "WSL")
end)()

return require("packer").startup {
  function(use)
    local local_use = function(first, second, opts)
      opts = opts or {}

      local plug_path, home
      if second == nil then
        plug_path = first
        home = "tjdevries"
      else
        plug_path = second
        home = first
      end

      if vim.fn.isdirectory(vim.fn.expand("~/plugins/" .. plug_path)) == 1 then
        opts[1] = "~/plugins/" .. plug_path
      else
        opts[1] = string.format("%s/%s", home, plug_path)
      end

      use(opts)
    end

    local py_use = function(opts)
      if not has "python3" then
        return
      end

      use(opts)
    end

    use "wbthomason/packer.nvim"
    use "lewis6991/impatient.nvim"
    -- use "camspiers/snap"

    -- My Plugins
    if not is_wsl then
      local_use "refactoring.nvim"
    end

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
    local_use "lazy.nvim"
    local_use("tjdevries", "astronauta.nvim", {
      -- setup = function()
      --   vim.g.astronauta_load_plugins = false
      -- end,
    })

    -- Contributor Plugins
    local_use("L3MON4D3", "LuaSnip")

    -- When I have some extra time...
    local_use "train.vim"
    local_use "command_and_conquer.nvim"
    local_use "streamer.nvim"
    local_use "bandaid.nvim"

    -- LSP Plugins:

    -- NOTE: lspconfig ONLY has configs, for people reading this :)
    use "neovim/nvim-lspconfig"
    use "wbthomason/lsp-status.nvim"

    local_use "lsp_extensions.nvim"
    use "onsails/lspkind-nvim"
    -- use "glepnir/lspsaga.nvim"
    -- https://github.com/rmagatti/goto-preview

    use {
      "akinsho/flutter-tools.nvim",
      ft = { "flutter", "dart" },
    }

    -- use "ray-x/go.nvim"
    -- https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils

    use {
      "folke/lsp-trouble.nvim",
      cmd = "LspTrouble",
      config = function()
        -- Can use P to toggle auto movement
        require("trouble").setup {
          auto_preview = false,
          auto_fold = true,
        }
      end,
    }

    use "rcarriga/nvim-notify"

    -- TODO: Investigate
    -- use 'jose-elias-alvarez/nvim-lsp-ts-utils'

    local_use("nvim-lua", "popup.nvim")
    local_use("nvim-lua", "plenary.nvim", {
      rocks = "lyaml",
    })

    local_use("nvim-telescope", "telescope.nvim")
    local_use("nvim-telescope", "telescope-fzf-writer.nvim")
    local_use("nvim-telescope", "telescope-packer.nvim")
    local_use("nvim-telescope", "telescope-fzy-native.nvim")
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use { "nvim-telescope/telescope-hop.nvim" }
    -- local_use("nvim-telescope", "telescope-async-sorter-test.nvim")

    local_use("nvim-telescope", "telescope-github.nvim")
    local_use("nvim-telescope", "telescope-symbols.nvim")

    use {
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("neoclip").setup()
      end,
    }

    -- TODO: When i'm back w/ some npm stuff, get this working.
    -- elianiva/telescope-npm.nvim

    local_use "telescope-hacks.nvim"
    local_use "sg.nvim"
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
    use "milisims/nvim-luaref"

    -- PRACTICE:
    use {
      "tpope/vim-projectionist", -- STREAM: Alternate file editting and some helpful stuff,
      enable = false,
    }

    -- For narrowing regions of text to look at them alone
    use {
      "chrisbra/NrrwRgn",
      cmd = { "NarrowRegion", "NarrowWindow" },
    }

    use "tweekmonster/spellrotate.vim"
    use "haya14busa/vim-metarepeat" -- Never figured out how to use this, but looks like fun.
    --
    -- VIM EDITOR:

    -- Little know features:
    --   :SSave
    --   :SLoad
    --       These are wrappers for mksession that work great. I never have to use
    --       mksession anymore or worry about where things are saved / loaded from.
    use {
      "mhinz/vim-startify",
      cmd = { "SLoad", "SSave" },
      config = function()
        vim.g.startify_disable_at_vimenter = true
      end,
    }

    -- Better profiling output for startup.
    use {
      "dstein64/vim-startuptime",
      cmd = "StartupTime",
    }

    -- Pretty colors
    use "norcalli/nvim-colorizer.lua"
    use {
      "norcalli/nvim-terminal.lua",
      config = function()
        require("terminal").setup()
      end,
    }

    -- Make comments appear IN YO FACE
    use {
      "tjdevries/vim-inyoface",
      config = function()
        vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>(InYoFace_Toggle)", {})
      end,
    }

    -- Show only what you're searching for.
    -- STREAM: Could probably make this a bit better. Definitely needs docs
    -- use "tjdevries/fold_search.vim"

    use {
      "tweekmonster/haunted.vim",
      cmd = "Haunt",
    }

    use {
      "tpope/vim-scriptease",
      cmd = {
        "Messages", --view messages in quickfix list
        "Verbose", -- view verbose output in preview window.
        "Time", -- measure how long it takes to run some stuff.
      },
    }

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
    -- use "kyazdani42/nvim-tree.lua"

    -- TODO: This would be cool to add back, but it breaks sg.nvim for now.
    -- use "lambdalisue/vim-protocol"

    -- Undo helper
    use "sjl/gundo.vim"

    -- TODO: This randomly disappeared? Find a replacement sometime.
    -- Make cool signs for your files
    -- use 'johannesthyssen/vim-signit'

    -- Crazy good box drawing
    use "gyim/vim-boxdraw"

    -- Better increment/decrement
    use "monaqa/dial.nvim"

    --   FOCUSING:
    local use_folke = true
    if use_folke then
      use "folke/zen-mode.nvim"
      use "folke/twilight.nvim"
    end

    use {
      "junegunn/goyo.vim",
      cmd = "Goyo",
      disable = use_folke,
    }

    use {
      "junegunn/limelight.vim",
      after = "goyo.vim",
      disable = use_folke,
    }

    --
    --
    --  LANGUAGE:
    -- TODO: Should check on these if they are the best ones
    use { "neovimhaskell/haskell-vim", ft = "haskell" }
    use { "elzr/vim-json", ft = "json" }
    use { "goodell/vim-mscgen", ft = "mscgen" }
    use "PProvost/vim-ps1"
    use "Glench/Vim-Jinja2-Syntax"
    use "justinmk/vim-syntax-extra"

    -- use "pearofducks/ansible-vim"
    -- use { "cespare/vim-toml", ft = "toml" }

    use { "ziglang/zig.vim", ft = "zig" }
    -- use { 'JuliaEditorSupport/julia-vim', ft = "julia" }

    use { "iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app && yarn install" }

    -- Typescript
    if false then
      use "jelera/vim-javascript-syntax"
      use "othree/javascript-libraries-syntax.vim"
      use "leafgarland/typescript-vim"
      use "peitalin/vim-jsx-typescript"

      use { "vim-scripts/JavaScript-Indent", ft = "javascript" }
      use { "pangloss/vim-javascript", ft = { "javascript", "html" } }

      -- Godot
      use "habamax/vim-godot"
      --
    end

    -- Wonder if I can make LSP do this and respect .prettier files.
    --  I don't write enough typescript to think about this.
    use {
      "prettier/vim-prettier",
      ft = { "html", "javascript", "typescript" },
      run = "yarn install",
    }

    -- TODO: Turn emmet back on when I someday use it
    -- use 'mattn/emmet-vim'

    use "tpope/vim-liquid"

    -- Sql
    use "tpope/vim-dadbod"
    use { "kristijanhusak/vim-dadbod-completion" }
    use { "kristijanhusak/vim-dadbod-ui" }

    --
    -- Lisp
    -- use { 'eraserhd/parinfer-rust', run = 'cargo build --release' }
    --
    -- STREAM: Figure out how to use snippets better
    --

    -- Completion
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "saadparwaiz1/cmp_luasnip"

    -- ddc.vim
    -- use "vim-denops/denops.vim"
    -- use "lambdalisue/guise.vim"
    -- use "Shougo/ddc.vim"
    -- use "Shougo/ddc-nvim-lsp"

    -- coq.nvim
    -- use { "ms-jpq/coq_nvim", branch = "coq" }

    -- Completion stuff
    local_use "rofl.nvim"

    -- use "hrsh7th/vim-vsnip"
    -- use "hrsh7th/vim-vsnip-integ"
    -- use 'norcalli/snippets.nvim'

    -- Cool tags based viewer
    --   :Vista  <-- Opens up a really cool sidebar with info about file.
    use { "liuchengxu/vista.vim", cmd = "Vista" }

    -- Find and replace
    use "windwp/nvim-spectre"

    -- Debug adapter protocol
    --   Have not yet checked this out, but looks awesome.
    -- use 'puremourning/vimspector'
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"
    use "theHamsta/nvim-dap-virtual-text"
    use "mfussenegger/nvim-dap-python"
    use "nvim-telescope/telescope-dap.nvim"

    -- Pocco81/DAPInstall.nvim

    use "jbyuki/one-small-step-for-vimkind"

    -- use {
    --   "rcarriga/vim-ultest",

    --   enable = false,
    --   requires = { "vim-test/vim-test" },
    --   run = ":UpdateRemotePlugins",
    --   config = function()
    --     vim.cmd [[nmap ]t <Plug>(ultest-next-fail)]]
    --     vim.cmd [[nmap [t <Plug>(ultest-prev-fail)]]
    --   end,
    -- }

    -- TREE SITTER:
    local_use("nvim-treesitter", "nvim-treesitter")
    use "nvim-treesitter/playground"
    use "vigoux/architext.nvim"

    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use {
      "mfussenegger/nvim-ts-hint-textobject",
      config = function()
        vim.cmd [[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
        vim.cmd [[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]
      end,
    }

    -- use {
    --   "romgrk/nvim-treesitter-context",
    --   config = function()
    --     require("treesitter-context.config").setup {
    --       enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    --     }

    --     -- TODO: Decide on a better highlighting color
    --     -- vim.cmd [[highlight TreesitterContext link NormalFloat]]
    --   end,
    -- }

    -- Grammars
    local_use "tree-sitter-lua"
    -- use { "m-novikov/tree-sitter-sql" }
    -- use { "DerekStride/tree-sitter-sql" }
    -- local_use "tree-sitter-sql"

    --
    -- NAVIGATION:
    -- STREAM: Show off edit_alternate.vim
    use {
      "tjdevries/edit_alternate.vim",
      keys = { "<leader>ea" },
      config = function()
        vim.fn["edit_alternate#rule#add"]("go", function(filename)
          if filename:find "_test.go" then
            return (filename:gsub("_test%.go", ".go"))
          else
            return (filename:gsub("%.go", "_test.go"))
          end
        end)
      end,
    }

    use "google/vim-searchindex"

    use "tamago324/lir.nvim"
    use "tamago324/lir-git-status.nvim"
    if executable "mmv" then
      use "tamago324/lir-mmv.nvim"
    end

    use "pechorin/any-jump.vim"

    --
    -- TEXT MANIUPLATION
    use "godlygeek/tabular" -- Quickly align text by pattern
    use "tpope/vim-commentary" -- Easily comment out lines or objects
    use "tpope/vim-repeat" -- Repeat actions better
    use "tpope/vim-abolish" -- Cool things with words!
    use "tpope/vim-characterize"
    use { "tpope/vim-dispatch", cmd = { "Dispatch", "Make" } }

    use {
      "AndrewRadev/splitjoin.vim",
      keys = { "gJ", "gS" },
    }

    -- TODO: Check out macvhakann/vim-sandwich at some point
    use "tpope/vim-surround" -- Surround text objects easily

    --
    -- GIT:
    use "TimUntersberger/neogit"

    -- Github integration
    if vim.fn.executable "gh" == 1 then
      use "pwntester/octo.nvim"
    end
    use "ruifm/gitlinker.nvim"

    -- Sweet message committer
    use "rhysd/committia.vim"
    use "sindrets/diffview.nvim"

    -- Floating windows are awesome :)
    use {
      "rhysd/git-messenger.vim",
      keys = "<Plug>(git-messenger)",
    }

    -- Async signs!
    use "lewis6991/gitsigns.nvim"

    -- Git worktree utility6
    use {
      "ThePrimeagen/git-worktree.nvim",
      config = function()
        require("git-worktree").setup {}
      end,
      disable = true,
    }

    use "ThePrimeagen/harpoon"

    -- use 'untitled-ai/jupyter_ascending.vim'

    use "tjdevries/standard.vim"
    use "tjdevries/conf.vim"

    use { "junegunn/fzf", run = "./install --all" }
    use { "junegunn/fzf.vim" }

    if false and vim.fn.executable "neuron" == 1 then
      use {
        "oberblastmeister/neuron.nvim",
        branch = "unstable",
        config = function()
          -- these are all the default values
          require("neuron").setup {
            virtual_titles = true,
            mappings = true,
            run = nil,
            neuron_dir = "~/neuron",
            leader = "gz",
          }
        end,
      }
    end

    use {
      "alec-gibson/nvim-tetris",
      cmd = "Tetris",
    }

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

    use { "Vhyrro/neorg", branch = "unstable" }

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
