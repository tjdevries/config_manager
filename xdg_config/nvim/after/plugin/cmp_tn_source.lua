if true then
  return
end

local source = {}

source.new = function()
  return setmetatable({
    get_entries = source.get_entries,
  }, { __index = source })
end

local count = 0
LIVE_COMPLETE = function(cb)
  count = count + 1
  cb {
    items = {
      {
        label = "Have you considered Rust?" .. tostring(count),
        kind = "TabNine",
        documentation = {
          kind = "markdown",
          value = "# C++ MUST DIE\n\nLong live Rust. Long live the crab. Ferris4Lyfe",
        },
        -- detail = "The only true language",
      },
      { label = "Writing C++", kind = "Text", tags = { 1 } },
    },
  }
end

source.complete = function(self, _, callback)
  LIVE_COMPLETE(callback)
end

-- source.get_trigger_characters = function()
--   return { "#include" }
-- end

if not SOURCE_DONE then
  require("cmp").register_source("tn", source.new())
end

SOURCE_DONE = true
