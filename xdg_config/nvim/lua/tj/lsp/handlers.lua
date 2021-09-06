-- Jump directly to the first available definition every time.
vim.lsp.handlers["textDocument/definition"] = function(_, result)
  if not result or vim.tbl_isempty(result) then
    print "[LSP] Could not find definition"
    return
  end

  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1])
  else
    vim.lsp.util.jump_to_location(result)
  end
end

-- vim.lsp.handlers["textDocument/definition"] = vim.lsp.with(
--   vim.lsp.handlers.location, {
--     location_callback = function(location)
--       vim.cmd [[vsplit]]
--       vim.lsp.util.jump_to_location(location)
--     end
--   }
-- )

-- Normal configuration, but for now testing out workspace configuration.
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     signs = {
--       severity_limit = "Error",
--     },
--     -- virtual_text = {
--     --   severity_limit = "Warning",
--     -- },
--   }
-- )
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  require("lsp_extensions.workspace.diagnostic").handler,
  {
    signs = {
      severity_limit = "Error",
    },
    underline = {
      severity_limit = "Warning",
    },
    virtual_text = true,
  }
)

vim.lsp.handlers["window/showMessage"] = function(...)
  return R "tj.lsp.show_message"(...)
end

local ns_rename = vim.api.nvim_create_namespace "tj_rename"

function MyLspRename()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns_rename, 0, -1)

  local current_word = vim.fn.expand "<cword>"

  local plenary_window = require("plenary.window.float").percentage_range_window(0.5, 0.2)
  vim.api.nvim_buf_set_option(plenary_window.bufnr, "buftype", "prompt")
  vim.fn.prompt_setprompt(plenary_window.bufnr, string.format('Rename "%s" to > ', current_word))
  vim.fn.prompt_setcallback(plenary_window.bufnr, function(text)
    vim.api.nvim_win_close(plenary_window.win_id, true)

    if text ~= "" then
      vim.schedule(function()
        vim.api.nvim_buf_delete(plenary_window.bufnr, { force = true })

        vim.lsp.buf.rename(text)
      end)
    else
      print "Nothing to rename!"
    end
  end)

  vim.cmd [[startinsert]]
end

-- -- Only want to do this config when Uivonim is in use, so do a check for that.
-- if vim.g.uivonim == 1 then
--   -- Get the override callbacks.
--   local lsp_callbacks = require'uivonim.lsp'.callbacks

--   nvim_lsp.texlab.setup {
--     -- Pass in the callbacks to override the defaults with Uivonim's.
--     handlers = lsp_callbacks;

--     -- Can still use other options, like this on_attach function
--     -- from nvim-lua/completion-nvim (recommended).
--     on_attach = require('completion').on_attach
--   }

--   nvim_lsp.tsserver.setup {
--     callbacks = lsp_callbacks;
--   }

--   -- Etc.
-- end

GoImports = function(timeoutms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, "t", true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context
  local method = "textDocument/codeAction"
  local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)
  if resp and resp[1] then
    local result = resp[1].result
    if result and result[1] then
      local edit = result[1].edit
      vim.lsp.util.apply_workspace_edit(edit)
    end
  end
  vim.lsp.buf.formatting_sync()
end

local M = {}

M.implementation = function()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, "textDocument/implementation", params, function(err, result, ctx, config)
    local bufnr = ctx.bufnr
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")

    -- In go code, I do not like to see any mocks for impls
    if ft == "go" then
      local new_result = vim.tbl_filter(function(v)
        return not string.find(v.uri, "mock_")
      end, result)

      if #new_result > 0 then
        result = new_result
      end
    end

    vim.lsp.handlers["textDocument/implementation"](err, result, ctx, config)
    vim.cmd [[normal! zz]]
  end)
end

return M
