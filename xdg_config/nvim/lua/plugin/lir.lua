local has_lir, lir = pcall(require, "lir")
if not has_lir then
  return
end

local has_devicons, devicons = pcall(require, "nvim-web-devicons")
if has_devicons then
  devicons.setup {
    override = {
      lir_folder_icon = {
        icon = "",
        color = "#7ebae4",
        name = "LirFolderNode",
      },
    },
  }
end

local actions = require "lir.actions"

lir.setup {
  show_hidden_files = true,
  devicons_enable = true,

  mappings = {
    ["<CR>"] = actions.edit,
    ["-"] = actions.up,

    ["K"] = actions.mkdir,
    ["N"] = actions.newfile,
    ["R"] = actions.rename,
    ["Y"] = actions.yank_path,
  },
}

vim.api.nvim_set_keymap("n", "-", ":edit %:h<CR>", { noremap = true })

-- Can do this if we want to get particular settings
-- vim.cmd [[
--   augroup LirSettings
--     au!
--     autocmd Filetype lir :lua LirSettings()
--   augroup END
-- ]]

-- Recommended actions, can play with these some more later.
-- ['l']     = actions.edit,
-- ['<C-s>'] = actions.split,
-- ['<C-v>'] = actions.vsplit,
-- ['<C-t>'] = actions.tabedit,

-- ['h']     = actions.up,
-- ['q']     = actions.quit,

-- ['K']     = actions.mkdir,
-- ['N']     = actions.newfile,
-- ['R']     = actions.rename,
-- ['@']     = actions.cd,
-- ['Y']     = actions.yank_path,
-- ['.']     = actions.toggle_show_hidden,
-- ['D']     = actions.delete,

-- ['J'] = function()
--   mark_actions.toggle_mark()
--   vim.cmd('normal! j')
-- end,
-- ['C'] = clipboard_actions.copy,
-- ['X'] = clipboard_actions.cut,
-- ['P'] = clipboard_actions.paste,
