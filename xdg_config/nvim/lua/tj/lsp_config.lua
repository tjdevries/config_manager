local lspconfig = require('lspconfig')
local nvim_status = require('lsp-status')
local completion = require('completion')

local telescope_mapper = require('tj.telescope.mappings')

local status = require('tj.lsp_status')

-- Can set this lower if needed.
-- require('vim.lsp.log').set_level("debug")
-- require('vim.lsp.log').set_level("trace")

local mapper = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
end

-- Turn on status.
-- status.activate()

local custom_attach = function(client)
  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end

  completion.on_attach(client)
  -- status    .on_attach(client)

  mapper('n', '<space>dn', 'vim.lsp.diagnostic.goto_next()')
  mapper('n', '<space>dp', 'vim.lsp.diagnostic.goto_prev()')
  mapper('n', '<space>sl', 'vim.lsp.diagnostic.show_line_diagnostics()')

  mapper('n', '<c-]>', 'vim.lsp.buf.definition()')
  mapper('n', 'gr', 'vim.lsp.buf.references()')
  mapper('n', '<space>cr', 'MyLspRename()')

  telescope_mapper('gr', 'lsp_references', nil, true)
  telescope_mapper('<space>fw', 'lsp_workspace_symbols', { ignore_filename = true }, true)
  telescope_mapper('<space>ca', 'lsp_code_actions', nil, true)

  -- mapper('n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  -- mapper('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  -- mapper('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>')

  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
  if filetype ~= 'lua' then
    mapper('n', 'K', 'vim.lsp.buf.hover()')
  end

  mapper('i', '<c-s>', 'vim.lsp.buf.signature_help()')

  -- Rust is currently the only thing w/ inlay hints
  if filetype == 'rust' then
    vim.cmd(
      [[autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { ]]
        .. [[aligned = true, prefix = " » " ]]
      .. [[} ]]
    )
  end

  if vim.tbl_contains({"go", "rust"}, filetype) then
    vim.cmd [[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()]]
  end

  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
end

lspconfig.pyls.setup({
  enable = true,
  plugins = {
    pyls_mypy = {
      enabled = true,
      live_mode = false
    }
  },
  on_attach = custom_attach
})

lspconfig.vimls.setup({
  on_attach = custom_attach,
})

lspconfig.gopls.setup {
  on_attach = custom_attach,
}

lspconfig.gdscript.setup {
  on_attach = custom_attach,
}

-- Load lua configuration from nlua.
if true then
  require('nlua.lsp.nvim').setup(lspconfig, {
    on_attach = custom_attach,

    globals = {
      -- Colorbuddy
      "Color", "c", "Group", "g", "s",

      -- Custom
      "RELOAD",
    }
  })
else
  -- This is the documentation example from ":help".
  --    I just keep it here to test w/ it.
  local custom_lsp_attach = function(client)
    -- See `:help nvim_buf_set_keymap()` for more information
    vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
    vim.api.nvim_buf_set_keymap(0, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
    -- ... and other keymappings for LSP

    -- Use LSP as the handler for omnifunc.
    --    See `:help omnifunc` and `:help ins-completion` for more information.
    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- For plugins with an `on_attach` callback, call them here. For example:
    -- require('completion').on_attach(client)
  end

  -- An example of configuring for `sumneko_lua`,
  --  a language server for Lua.
  -- First, you must run `:LspInstall sumneko_lua` for this to work.
  require('lspconfig').sumneko_lua.setup({
    -- An example of settings for an LSP server.
    --    For more options, see nvim-lspconfig
    settings = {
      Lua = {
        diagnostics = {
          enable = true,
          globals = { "vim" },
        },
      }
    },

    on_attach = custom_lsp_attach
  })
end

if true then
  lspconfig.tsserver.setup({
    cmd = {"typescript-language-server", "--stdio"},
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx"
    },
    on_attach = custom_attach
  })
else
  lspconfig.sourcegraph_ts.setup {
    on_attach = custom_attach
  }
end

lspconfig.clangd.setup({
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
  on_attach = custom_attach,

  -- Required for lsp-status
  init_options = {
    clangdFileStatus = true
  },
  handlers = nvim_status.extensions.clangd.setup(),
  capabilities = nvim_status.capabilities,
})

lspconfig.rust_analyzer.setup({
  cmd = {"rust-analyzer"},
  filetypes = {"rust"},
  on_attach = custom_attach,
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = false
      }
    ),
  }
})

--[[
Example settings, have not messed around with too many of these.
-- require 'lspconfig'.pyls_ms.setup{
--     init_options = {
--         interpreter = {
--             properties = {
--                 InterpreterPath = "~/.pyenv/versions/sourceress/bin/python",
--                 Version = "3.6"
--             }
--         }
--     }
-- }
let settings = {
\   "pyls" : {
\     "enable" : v:true,
\     "trace" : { "server" : "verbose", },
\     "commandPath" : "",
\     "configurationSources" : [ "pycodestyle" ],
\     "plugins" : {
\       "jedi_completion" : { "enabled" : v:true, },
\       "jedi_hover" : { "enabled" : v:true, },
\       "jedi_references" : { "enabled" : v:true, },
\       "jedi_signature_help" : { "enabled" : v:true, },
\       "jedi_symbols" : {
\         "enabled" : v:true,
\         "all_scopes" : v:true,
\       },
\       "mccabe" : {
\         "enabled" : v:true,
\         "threshold" : 15,
\       },
\       "preload" : { "enabled" : v:true, },
\       "pycodestyle" : { "enabled" : v:true, },
\       "pydocstyle" : {
\         "enabled" : v:false,
\         "match" : "(?!test_).*\\.py",
\         "matchDir" : "[^\\.].*",
\       },
\       "pyflakes" : { "enabled" : v:true, },
\       "rope_completion" : { "enabled" : v:true, },
\       "yapf" : { "enabled" : v:true, },
\     }}}
--]]


function MyLspRename()
  local current_word = vim.fn.expand("<cword>")
  local plenary_window = require('plenary.window.float').percentage_range_window(0.5, 0.2)
  vim.api.nvim_buf_set_option(plenary_window.bufnr, 'buftype', 'prompt')
  vim.fn.prompt_setprompt(plenary_window.bufnr, string.format('Rename "%s" to > ', current_word))
  vim.fn.prompt_setcallback(plenary_window.bufnr, function(text)
    vim.api.nvim_win_close(plenary_window.win_id, true)

    if text ~= '' then
      vim.schedule(function()
        vim.api.nvim_buf_delete(plenary_window.bufnr, { force = true })

        vim.lsp.buf.rename(text)
      end)
    else
      print("Nothing to rename!")
    end
  end)

  vim.cmd [[startinsert]]
end

local sign_decider
if true then
  sign_decider = function(bufnr)
    local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
    -- No buffer local variable set, so just enable by default
    if not ok then
      return true
    end

    return result
  end
else
  -- LOL, alternate signs.
  sign_decider = coroutine.wrap(function()
    while true do
      coroutine.yield(true)
      coroutine.yield(false)
    end
  end)
end

--[[
0. nil -> do default (could be enabled or disabled)
1. false -> disable it
2. true -> enable, use defaults
3. table -> enable, with (some) overrides
4. function -> can return any of above
--]]

--[ An example of using functions...
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, method, params, client_id, bufnr, config)
  local uri = params.uri

  vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = true,
      signs = sign_decider,
      update_in_insert = false,
    }
  )(err, method, params, client_id, bufnr, config)

  bufnr = bufnr or vim.uri_to_bufnr(uri)

  if bufnr == vim.api.nvim_get_current_buf() then
    vim.lsp.diagnostic.set_loclist { open_loclist = false }
  end
end
--]]

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = true,
    signs = sign_decider,
    update_in_insert = false,
  }
)


if false then
vim.lsp.diagnostic.get_virtual_text_chunks_for_line = function(bufnr, line, line_diagnostics)
  if #line_diagnostics == 0 then
    return nil
  end

  local line_length = #(vim.api.nvim_buf_get_lines(bufnr, line, line + 1, false)[1] or '')
  local get_highlight = vim.lsp.diagnostic._get_severity_highlight_name

  -- Create a little more space between virtual text and contents
  local virt_texts = {{string.rep(" ", 80 - line_length)}}

  for i = 1, #line_diagnostics - 1 do
    table.insert(virt_texts, {"■", get_highlight(line_diagnostics[i].severity)})
  end
  local last = line_diagnostics[#line_diagnostics]
  -- TODO(ashkan) use first line instead of subbing 2 spaces?

  -- TODO(tjdevries): Allow different servers to be shown first somehow?
  -- TODO(tjdevries): Display server name associated with these?
  if last.message then
    table.insert(
      virt_texts,
      {
        string.format("■ %s", last.message:gsub("\r", ""):gsub("\n", "  ")),
        get_highlight(last.severity)
      }
    )

    return virt_texts
  end

  return virt_texts
end
end
