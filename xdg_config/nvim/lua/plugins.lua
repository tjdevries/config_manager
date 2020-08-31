-- On ly required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  -- TODO: Maybe handle windows better?
  if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
    return
  end

  local directory = string.format(
    '%s/site/pack/packer/opt/',
    vim.fn.stdpath('data')
  )

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    directory .. '/packer.nvim'
  ))

  print(out)
  print("Downloading packer.nvim...")

  return
end

return require('packer').startup {
  function(use)
    local local_use = function(plug_path)
      if vim.fn.isdirectory(vim.fn.expand("~/plugins/" .. plug_path)) == 1 then
        use("~/plugins/" .. plug_path)
      else
        use('tjdevries/' .. plug_path)
      end
    end

    -- My Plugins
    local_use 'nlua.nvim'
    local_use 'tree-sitter-nlua'
    local_use 'vlog.nvim'
    local_use 'vim9jit'
    local_use 'colorbuddy.vim'
    local_use 'gruvbuddy.nvim'
    local_use 'plenary.nvim'
    local_use 'apyrori.nvim'
    local_use 'py_package.nvim'
    local_use 'manillua.nvim'
    local_use 'riki.nvim'
    local_use 'cyclist.vim'
    local_use 'bandaid.nvim'
    local_use 'popup.nvim'
    local_use 'train.vim'
    local_use 'express_line.nvim'
    local_use 'overlength.vim'
    local_use 'pastery.vim'
    local_use 'telescope.nvim'
    local_use 'command_and_conquer.nvim'

    local_use 'lsp_extensions.nvim'

    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    -- PRACTICE: {{{
    use 'tpope/vim-projectionist'  -- STREAM: Alternate file editting and some helpful stuff

    -- For narrowing regions of text to look at them alone
    use 'chrisbra/NrrwRgn' -- Figure out some good ways to use this on stream

    use {'rhysd/vim-clang-format', rocks = { 'lua-cjson', 'lpeg', 'asdf' }}
    use 'tweekmonster/spellrotate.vim'
    use 'haya14busa/vim-metarepeat'  -- Never figured out how to use this, but looks like fun.
    -- }}}
    -- VIM EDITOR: {{{

    -- Little know features:
    --   :SSave
    --   :SLoad
    --       These are wrappers for mksession that work great. I never have to use
    --       mksession anymore or worry about where things are saved / loaded from.
    use 'mhinz/vim-startify'

    -- Better profiling output for startup.
    use 'dstein64/vim-startuptime'
    -- use 'tweekmonster/startuptime.vim'  -- Might switch back to this, but they are incompatible.

    -- Pretty colors
    use 'norcalli/nvim-colorizer.lua'

    -- Make comments appear IN YO FACE
    use 'tjdevries/vim-inyoface'

    -- Show only what you're searching for.
    -- STREAM: Could probably make this a bit better. Definitely needs docs
    use 'tjdevries/fold_search.vim'

    use 'tweekmonster/exception.vim'
    use 'tweekmonster/haunted.vim'

    -- :Messages <- view messages in quickfix list
    -- :Verbose  <- view verbose output in preview window.
    -- :Time     <- measure how long it takes to run some stuff.
    use 'tpope/vim-scriptease'

    -- Quickfix enhancements. See :help vim-qf
    use 'romainl/vim-qf'

    use {
      'glacambre/firenvim',
      run = function()
        vim.fn['firenvim#install'](0)
      end
    }

    -- TODO: Eventually statusline should consume this.
    use 'mkitt/tabline.vim'

    -- Pretty icons. Not necessarily required.
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'

    -- Undo helper
    use 'sjl/gundo.vim'

    -- Make cool signs for your files
    use 'johannesthyssen/vim-signit'

    --   FOCUSING: {{{
    use 'junegunn/goyo.vim'
    use 'junegunn/limelight.vim'
    --   }}}
    -- }}}
    --  LANGUAGE: {{{
    -- TODO: Should check on these if they are the best ones
    use 'neovimhaskell/haskell-vim'
    use 'justinmk/vim-syntax-extra'
    use 'elzr/vim-json'
    use 'goodell/vim-mscgen'
    use 'pearofducks/ansible-vim'
    use 'PProvost/vim-ps1'
    use 'cespare/vim-toml'
    use 'Glench/Vim-Jinja2-Syntax'

    -- Lua {{{
    use 'euclidianAce/BetterLua.vim'
    -- }}}

    -- Typescript {{{
    -- TODO: Should probably only load these when necessary.
    -- TODO: Should prboably check if these work for typescript, typescript.tsx, etc.
    use 'jelera/vim-javascript-syntax'
    use 'othree/javascript-libraries-syntax.vim'
    use 'leafgarland/typescript-vim'
    use 'peitalin/vim-jsx-typescript'

    use { 'prettier/vim-prettier', run = 'yarn install' }

    use 'mattn/emmet-vim'
    use { 'vim-scripts/JavaScript-Indent', ft = 'javascript' }
    use { 'pangloss/vim-javascript', ft = { 'javascript', 'html' } }
    use 'tpope/vim-liquid'
    -- }}}
    --  }}}
    -- LSP {{{

    -- Configurations for neovim lsp.
    --   neovim/neovim has all of the LSP code.
    use 'neovim/nvim-lsp'

    -- STREAM: Figure out how to use snippets better
    use 'haorenW1025/completion-nvim'

    -- use 'hrsh7th/vim-vsnip'
    -- use 'hrsh7th/vim-vsnip-integ'
    use 'norcalli/snippets.nvim'
    use 'norcalli/ui.nvim'

    -- TODO: Merge in my LSP PR...
    -- Plug 'haorenW1025/diagnostic-nvim'

    use 'wbthomason/lsp-status.nvim'

    -- Cool tags based viewer
    --   :Vista  <-- Opens up a really cool sidebar with info about file.
    use 'liuchengxu/vista.vim'

    -- Debug adapter protocol
    --   Have not yet checked this out, but looks awesome.
    use 'puremourning/vimspector'
    -- }}}
    -- TREE SITTER: {{{
    local_use 'nvim-treesitter'
    use 'nvim-treesitter/playground'

    -- }}}
    -- NAVIGATION: {{{
    -- STREAM: Show off edit_alternate.vim
    use 'tjdevries/edit_alternate.vim'

    use 'google/vim-searchindex'

    use 'justinmk/vim-dirvish'
    use 'pechorin/any-jump.vim'
    use 'andymass/vim-matchup'

    -- }}}
    -- TEXT MANIUPLATION {{{
    use 'godlygeek/tabular'        -- Quickly align text by pattern
    use 'tpope/vim-surround'       -- Surround text objects easily
    use 'tpope/vim-speeddating'    -- Handle changing of dates in a nicer manner
    use 'tpope/vim-commentary'     -- Easily comment out lines or objects
    use 'tpope/vim-repeat'         -- Repeat actions better
    use 'tpope/vim-abolish'        -- Cool things with words!
    use 'tpope/vim-characterize'
    use 'AndrewRadev/splitjoin.vim'
    use 'AndrewRadev/sideways.vim' -- Easy sideways movement

    -- Do I even use any of these?
    use 'kana/vim-textobj-user'
    use 'bps/vim-textobj-python'
    -- }}}
    -- GIT: {{{
    -- gita replacement
    use 'lambdalisue/gina.vim'
    use 'kdheepak/lazygit.nvim'

    -- Sweet message committer
    use 'rhysd/committia.vim'

    -- Floating windows are awesome :)
    use 'rhysd/git-messenger.vim'

    -- Async signs!
    if vim.fn.has 'unix' then
      use 'mhinz/vim-signify'
    end
    -- }}}

    use 'untitled-ai/jupyter_ascending.vim'

    use 'tjdevries/standard.vim'
    use 'tjdevries/conf.vim'
    use 'junegunn/vader.vim'

    use {'junegunn/fzf', run = './install --all' }     -- Fuzzy Searcher
    use {'junegunn/fzf.vim'}
    -- use {'yuki-ycino/fzf-preview.vim', run = 'yarn global add' }
    use {'yuki-ycino/fzf-preview.vim', run = 'npm install' }

    use 'lervag/wiki.vim'
    use 'ihsanturk/neuron.vim'

    use 'ThePrimeagen/vim-apm'
  end,
  config = {
    display = {
      _open_fn = function(name)
        -- Can only use plenary when we have our plugins.
        --  We can only get plenary when we don't have our plugins ;)
        local ok, float_win = pcall(function()
          return require('plenary.window.float').percentage_range_window(0.8, 0.8)
        end)

        if not ok then
          vim.cmd [[65vnew  [packer] ]]

          return vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
        end

        local bufnr = float_win.buf
        local win = float_win.win

        vim.api.nvim_buf_set_name(bufnr, name)
        vim.api.nvim_win_set_option(win, 'winblend', 10)

        return win, bufnr
      end
    },
  }
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

--[[ Graveyard

can check these out some time for ideas on how to do this:
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt', { 'on': 'FormatCode' }
Plug 'google/vim-glaive'

-- I don't think I need these anymore because they are handled by plugins I use already
if has('unix')
  Plug 'Shougo/echodoc.vim'
  Plug 'Shougo/context_filetype.vim'
  endif

  if has('python3') && g:my_deoplete_enabled
    Plug 'Shougo/deoplete.nvim'

    Plug 'Shougo/neco-vim'
    Plug 'Shougo/neco-syntax'

    if executable('zsh')
      Plug 'deoplete-plugins/deoplete-zsh'
      endif

      if executable('racer') " TODO: Maybe check racer?
        Plug 'rust-lang/rust.vim'                        " Realistically. we only need this when we have rust as well
        Plug 'sebastianmarkow/deoplete-rust'             " Rust completion
        endif

        " Gotta choose electric boogaloo
        Plug 'tweekmonster/deoplete-clang2'                 " C-Family languages

        " Works, but not using
        " Plug 'eagletmt/neco-ghc'

        " Emojis :)
        Plug 'fszymanski/deoplete-emoji'

        " Can't seem to get to work on windows as of right now.
        " Will make an issue if I can't figure it out.
        if executable('tsc') && has('unix')
          Plug 'mhartington/nvim-typescript', {'for': 'typescript'}
          endif
          endif

          " Tag Based Plugins {{{
            if executable('ctags')
              Plug 'jsfaint/gen_tags.vim'

              if has('unix')
                Plug 'majutsushi/tagbar'
                endif
                endif
                -- }}}

                --]]
