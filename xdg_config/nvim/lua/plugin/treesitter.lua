-- mapping of user defined captures to highlight groups
local custom_captures = {
  -- highlight own capture @foo.bar with highlight group "Identifier", see :h nvim-treesitter-query-extensions
  ['foo.bar'] = 'Identifier',
  ['function.call'] = 'LuaFunctionCall',
  ['function.bracket'] = 'Type',

  ['namespace.type'] = 'TSNamespaceType',
}

require('nvim-treesitter.configs').setup {
  -- ensure_installed = {'lua'}, -- one of 'all', 'language', or a list of languages
  ensure_installed = { 'go', 'rust', 'toml', 'query', },

  highlight = {
    enable = true, -- false will disable the whole extension
    use_languagetree = false,
    disable = {"json", "rust"},
    custom_captures = custom_captures,
  },

  incremental_selection = {
    enable = true,
    keymaps = { -- mappings for incremental selection (visual mappings)
      init_selection = '<M-w>',    -- maps in normal mode to init the node/scope selection
      node_incremental = '<M-w>',  -- increment to the upper named parent
      scope_incremental = '<M-e>', -- increment to the upper scope (as defined in locals.scm)
      node_decremental = '<M-C-w>',  -- decrement to the previous node
    },
  },

  refactor = {
    highlight_definitions = {enable = true},
    highlight_current_scope = {enable = false},

    smart_rename = {
      enable = false,
      keymaps = {
        -- mapping to rename reference under cursor
        smart_rename = 'grr',
      },
    },

    -- TODO: This seems broken...
    navigation = {
      enable = false,
      keymaps = {
        goto_definition = 'gnd', -- mapping to go to definition of symbol under cursor
        list_definitions = 'gnD', -- mapping to list all definitions in current file
      },
    },
  },

  -- textobjects = { -- syntax-aware textobjects
  --   enable = true,
  --   disable = {},
  --   keymaps = {
  --     ['iL'] = { -- you can define your own textobjects directly here
  --       python = '(function_definition) @function',
  --       cpp = '(function_definition) @function',
  --       c = '(function_definition) @function',
  --       java = '(method_declaration) @function',
  --     },
  --     -- or you use the queries from supported languages with textobjects.scm
  --     ['af'] = '@function.outer',
  --     ['if'] = '@function.inner',
  --     ['aC'] = '@class.outer',
  --     ['iC'] = '@class.inner',
  --     ['ac'] = '@conditional.outer',
  --     ['ic'] = '@conditional.inner',
  --     ['ae'] = '@block.outer',
  --     ['ie'] = '@block.inner',
  --     ['al'] = '@loop.outer',
  --     ['il'] = '@loop.inner',
  --     ['is'] = '@statement.inner',
  --     ['as'] = '@statement.outer',
  --     ['ad'] = '@comment.outer',
  --     ['am'] = '@call.outer',
  --     ['im'] = '@call.inner',
  --   },
  -- },
}

vim.cmd [[highlight IncludedC guibg=#373b41]]

--[[

-- From python, get all the things we import, update __all__

(import_from_statement name: (*) @Importer)

(
 (assignment left: (expression_list (identifier)) @assign)
 (#eq? @assign "__all__")
)

--]]

-- require('tj.ts')
