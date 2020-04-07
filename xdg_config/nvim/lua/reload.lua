local system_modules = {
    "fiber",
    "ffi",
    "io",
    "console",
    "digest",
    "json",
    "uri",
    "jit.dis_x64",
    "box.internal.gc",
    "box._lib",
    "crypto",
    "net.box",
    "internal.argparse",
    "jit.opt",
    "uuid",
    "fio",
    "pwd",
    "internal.trigger",
    "jit.p",
    "jit.vmdef",
    "os",
    "string",
    "debug",
    "jit.profile",
    "socket",
    "box.internal.sequence",
    "tap",
    "coroutine",
    "net.box.lib",
    "jit.dump",
    "pickle",
    "msgpack",
    "jit.dis_x86",
    "box.backup",
    "jit",
    "jit.v",
    "buffer",
    "box",
    "yaml",
    "xlog",
    "errno",
    "bit",
    "box.internal",
    "jit.zone",
    "table",
    "msgpackffi",
    "jit.util",
    "csv",
    "help.en_US",
    "jit.bcsave",
    "box.internal.session",
    "jit.bc",
    "math",
    "fun",
    "table.new",
    "tarantool",
    "http.client",
    "http.codes",
    "http.lib",
    "http.mime_types",
    "http.server",
    "title",
    "_G",
    "table.clear",
    "help",
    "strict",
    "package",
    "clock",
    "iconv"
}

if rawget(_G, "_blacklisted_modules") == nil then
    _G._blacklisted_modules = {}
end

local function blacklist(module_name)
    _G._blacklisted_modules[module_name] = true
end

local function is_blacklisted(module_name)
    if _G._blacklisted_modules == nil then
        return false
    end

    if _G._blacklisted_modules[module_name] then
        return true
    end

    return false
end

local function has_value(array, value)
    for _, v in ipairs(array) do
        if v == value then
            return true
        end
    end

    return false
end

local function reload()
    local unload = {}

    for module_name, module_table in pairs(package.loaded) do
        if not has_value(system_modules, module_name) and
           not is_blacklisted(module_name) then
            if type(module_table) ~= 'table' then
                module_table = {}
            end

            unload[module_name] = module_table
            package.loaded[module_name] = nil
        end
    end

    for module_name, _ in pairs(unload) do
        local rc, res = pcall(require, module_name)

        if rc and type(res) ~= 'table' then
            rc, res = false, string.format("Module '%s' is expected to return a table. Got: '%s'", module_name, type(res))
        end

        if not rc then
            for module_name, module_table in pairs(unload) do
                package.loaded[module_name] = module_table
            end
            return nil, res
        end
    end

    for module_name, old_module_table in pairs(unload) do
        local new_module_table = package.loaded[module_name]

        for k, _ in pairs(old_module_table) do
            if new_module_table[k] == nil then
                old_module_table[k] = nil
            end
        end

        for k, v in pairs(new_module_table) do
            old_module_table[k] = v
        end

        package.loaded[module_name] = old_module_table
    end

    for module_name, _ in pairs(unload) do
        print("Reloaded module: " .. module_name)
    end

    return true
end

return {reload=reload, blacklist=blacklist}
