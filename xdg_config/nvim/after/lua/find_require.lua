local finder = {}

function finder.find_require(...)
    local to_search

    local args = {...}
    if #args > 0 then
        to_search = args[1]
    else
        local line = vim.fn.getline('.')

        -- require('.*')
        local result = string.match(line, [[require%('(.*)'%)]])

        -- require'.*'
        if result == nil then
            result = string.match(line [[require'(.*)']])
        end

        -- require(".*")
        if result == nil then
            result = string.match(line, [[require%("(.*)"%))]])
        end

        -- require".*"
        if result == nil then
            result = string.match(line [[require(".*"%)]])
        end

        to_search = result
    end

    local found_file = package.searchpath(to_search, package.path)

    if not found_file then
        found_file = package.searchpath(to_search, package.cpath)
    end

    if found_file == nil then
        vim.cmd('silent normal! gf')
    else
        vim.cmd(string.format('e %s', found_file))
    end
end

-- print(vim.inspect(package.searchpath("colorbuddy.group", package.path)))

return finder
