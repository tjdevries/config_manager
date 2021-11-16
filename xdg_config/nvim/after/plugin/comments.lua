local comment_ft = require "Comment.ft"

comment_ft.set("lua", { "--%s", "--[[%s]]" })

--- Pre hook
---@param ctx Ctx: The context for pre_hook
-- local pre_hook = function(ctx)
--   local comment_lang = comment_ft.lang(ctx.lang)
--   if ctx.contained then
--     print("Contained:", ctx.contained:type(), vim.inspect(comment_lang[ctx.contained:type()]))
--     local config = comment_lang[ctx.contained:type()]
--     return config[ctx.ctype] or config[1]
--   else
--     print "No node found"
--   end
-- end

require("Comment").setup {
  ignore = nil,

  -- LHS of operator-pending mapping in NORMAL + VISUAL mode
  opleader = {
    -- line-comment keymap
    line = "gc",
    -- block-comment keymap
    block = "gb",
  },

  -- Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
  mappings = {
    -- operator-pending mapping
    -- Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
    basic = true,

    -- extra mapping
    -- Includes `gco`, `gcO`, `gcA`
    extra = true,

    -- extended mapping
    -- Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
    extended = false,
  },

  -- LHS of toggle mapping in NORMAL + VISUAL mode
  -- @type table
  toggler = {
    -- line-comment keymap
    line = "gcc",

    -- block-comment keymap
    block = "gbc",
  },

  -- Pre-hook, called before commenting the line
  -- pre_hook = pre_hook,

  -- Post-hook, called after commenting is done
  post_hook = nil,
}
