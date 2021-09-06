local protocol = require "vim.lsp.protocol"

_LspMessageBuffer = _LspMessageBuffer or vim.api.nvim_create_buf(false, true)

local bufnr = _LspMessageBuffer
local border = {
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" },
}

local create_little_window = function(messages)
  local msg_lines = #messages

  local msg_width = 0
  for _, v in ipairs(messages) do
    msg_width = math.max(msg_width, #v + 1)
  end

  local ui = vim.api.nvim_list_uis()[1]
  local ui_width = ui.width

  local win_height = math.min(50, msg_lines)
  local win_width = math.min(150, msg_width) + 5

  return vim.api.nvim_open_win(bufnr, false, {
    relative = "editor",
    style = "minimal",
    height = win_height,
    width = win_width,
    -- row = ui_height - win_height - 10,
    row = 1,
    col = ui_width - win_width - 2,
    border = border,
  })
end

-- TODO: map this to a keybind :)
function LspShowMessageBuffer()
  vim.cmd [[new]]
  vim.cmd([[buffer ]] .. _LspMessageBuffer)
end

return function(_, result, ctx)
  local client_id = ctx.client_id

  local message_type = result.type
  local client_message = result.message
  local client = vim.lsp.get_client_by_id(client_id)
  local client_name = client and client.name or string.format("id=%d", client_id)

  local messages = {}

  if not client then
    error(string.format("LSP[%s] client has shut down after sending the message", client_name))
  end
  if message_type == protocol.MessageType.Error then
    error(string.format("LSP[%s] %s", client_name, client_message))
  else
    local message_type_name = protocol.MessageType[message_type]
    table.insert(messages, string.format("LSP %s %s", client_name, message_type_name))
    for index, text in ipairs(vim.split(client_message, "\n")) do
      table.insert(messages, "  " .. text .. "  ")
    end
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, messages)

  local win_id = create_little_window(messages)
  vim.cmd(string.format(
    [[
    autocmd CursorMoved * ++once :call nvim_win_close(%s, v:true)
  ]],
    win_id
  ))

  return result
end
