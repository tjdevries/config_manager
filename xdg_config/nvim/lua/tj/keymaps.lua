-- RELOAD('tj.keymaps')

local maps = {}

__TjMapStore = __TjMapStore or {}
maps._store = __TjMapStore

maps._create = function(f)
  table.insert(maps._store, f)
  return #maps._store
end

maps._execute = function(id)
  maps._store[id]()
end

local make_mapper = function(mode, defaults)
  return function(opts)
    local args, map_args = {}, {}
    for k, v in pairs(opts) do
      if type(k) == 'number' then
        args[k] = v
      else
        map_args[k] = v
      end
    end

    local lhs = opts.lhs or args[1]
    local rhs = opts.rhs or args[2]

    local mapping
    if type(rhs) == 'string' then
      error('not implemented')
    elseif type(rhs) == 'function' then
      local func_id = maps._create(rhs)

      mapping = string.format(
        [[:lua require('tj.keymaps')._execute(%s)<CR>]], func_id
      )
    end

    local map_opts = vim.tbl_extend("force", defaults, map_args)

    if not map_opts.buffer then
      vim.api.nvim_set_keymap(mode, lhs, mapping, map_opts)
    else
      -- Clear the buffer after saving it
      local buffer = map_opts.buffer
      map_opts.buffer = nil

      vim.api.nvim_buf_set_keymap(buffer, mode, lhs, mapping, map_opts)
    end
  end
end

--- Make a nnoremap
---@param opts table: lhs, function / string, ...map-opts
maps.nnoremap = make_mapper('n', { noremap = true })
maps.vnoremap = make_mapper('v', { noremap = true })
maps.inoremap = make_mapper('i', { noremap = true })

maps.nmap = make_mapper('n', { noremap = false })
maps.vmap = make_mapper('v', { noremap = false })
maps.imap = make_mapper('i', { noremap = false })

--[[
maps.nnoremap { 'lhs', 'rhs', silent = true }
--]]

return maps
