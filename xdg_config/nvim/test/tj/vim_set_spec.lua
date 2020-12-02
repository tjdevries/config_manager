require('plenary.test_harness'):setup_busted()

local eq = function(a, b)
  assert(a == b, string.format("%s was not equal to %s", a, b))
end

local tj_globals = require('tj.globals')

local convert_vimoption_to_lua = tj_globals.convert_vimoption_to_lua
local set = tj_globals.set

describe('vim.set', function()
  describe('convert_vimoption_to_lua', function()
    it('should leave bools, numbers untouched', function()
      eq(true, convert_vimoption_to_lua('', true))
      eq(5, convert_vimoption_to_lua('', 5))
    end)
  end)

  describe('set', function()
    it('should allow setting tables', function()
      set.wildignore = { 'hello', 'world' }
      eq(vim.o.wildignore, "hello,world")
    end)

    it('should allow adding tables', function()
      set.wildignore = 'foo'
      eq(vim.o.wildignore, 'foo')

      set.wildignore = set.wildignore + { 'bar', 'baz' }
      eq(vim.o.wildignore, 'bar,baz,foo')
    end)

    it('should not allow adding duplicates', function()
      set.wildignore = 'foo'
      eq(vim.o.wildignore, 'foo')

      set.wildignore = set.wildignore + { 'bar', 'baz' }
      eq(vim.o.wildignore, 'bar,baz,foo')

      set.wildignore = set.wildignore + { 'bar', 'baz' }
      eq(vim.o.wildignore, 'bar,baz,foo')
    end)

    it('should remove values when you use minus', function()
      set.wildignore = 'foo'
      eq(vim.o.wildignore, 'foo')

      set.wildignore = set.wildignore + { 'bar', 'baz' }
      eq(vim.o.wildignore, 'bar,baz,foo')

      set.wildignore = set.wildignore - 'bar'
      eq(vim.o.wildignore, 'baz,foo')
    end)
  end)
end)
