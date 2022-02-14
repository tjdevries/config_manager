-- instead of deps, we can call it `lua_modules` :cry:
--
-- TODO: Add `deps` stuff to `package.path` so then you could drop all of this in deps/
-- deps/
--  myplugin__plenary__commit

-- Could also add:
-- $ROOT/deps/
-- $ROOT/lua/deps/...
-- For now this works with $ROOT/lua/deps since then `require` bits get to work for free.
-- if we add a new searcher, then it would probably work fine either way.

local uv = vim.loop

-- YOU CAN ONLY CALL THIS FUNCTION FROM THE APPROPRIATE LEVEL OF NESTEDNESS
-- OTHERWISE YOU GET THE WRONG PATH. CAREFUL OF THIS ONE!
local function get_script_path()
  local path = debug.getinfo(3, "S").source:sub(2):match "(.*/)"
  return uv.fs_realpath(path)
end

local function find_plugin_root(path)
  -- TODO: Windows Sadge
  local parts = vim.split(path, "/")
  while #parts > 0 do
    local subpath = table.concat(parts, "/")
    if uv.fs_stat(subpath .. "/plugin.lua") then
      return subpath
    end

    table.remove(parts, #parts)
  end

  return nil
end

local function get_dep_name(name)
  name = string.gsub(name, "/", ".")
  return vim.split(name, "%.")[1]
end

local function make_dep_path(plug_name, dep_name, version, name)
  return string.format("deps.%s__%s__%s.lua.%s", plug_name, dep_name, version, name)
end

local dep = function(name)
  local plugin_script = get_script_path()
  local dep_name = get_dep_name(name)

  local plugin_root = find_plugin_root(plugin_script)
  if plugin_root then
    local plugin_config = loadfile(plugin_root .. "/plugin.lua")()
    local plugin_deps = plugin_config.dependencies
    if not plugin_deps[dep_name] then
      error(string.format("Could not find dependency: %s // %s", dep_name, name))
    end

    -- TODO: This is a bit goofy, but it makes it so that we can
    -- still use require easily.
    local dep_version = string.gsub(plugin_deps[dep_name], "%.", "-")
    local dep_path = make_dep_path(plugin_config.name, dep_name, dep_version, name)

    NESTED_REQUIRE = true
    local ok, mod = pcall(require, dep_path)
    NESTED_REQUIRE = false

    if not ok then
      error(mod)
    end

    return mod
    -- return setfenv(require, {
    --   require = function(req_name)
    --     error(req_name)
    --   end,
    -- })(dep_path)
  end

  error(string.format("Unable to find plugin root: %s // %s", name, plugin_script))
end

vim.dep = dep

-- TODO: These functions could be used to override `require` in the dependent modules...
-- not sure how to to that part yet.
dep_loader = function(...)
  local args = { ... }
  vim.schedule(function()
    print("Oh hey, we loading:: ", unpack(args))
  end)

  return nil
end

DEP_LOADER = DEP_LOADER or function(...)
  return dep_loader(...)
end

if package.loaders[1] ~= DEP_LOADER then
  print "INSERT DEP LOADER"
  table.insert(package.loaders, 1, DEP_LOADER)
end

return dep
