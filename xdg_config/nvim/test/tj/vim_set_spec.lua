require('plenary.test_harness'):setup_busted()

local eq = function(a, b)
  assert(a == b, string.format("%s was not equal to %s", a, b))
end

local tj_globals = require('tj.globals')

local convert_vimoption_to_lua = tj_globals.convert_vimoption_to_lua
local opt = tj_globals.opt

describe('vim.opt', function()
  describe('convert_vimoption_to_lua', function()
    it('should leave bools, numbers untouched', function()
      eq(true, convert_vimoption_to_lua('', true))
      eq(5, convert_vimoption_to_lua('', 5))
    end)
  end)

  describe('opt', function()
    it('should allow setting tables', function()
      opt.wildignore = { 'hello', 'world' }
      eq(vim.o.wildignore, "hello,world")
    end)

    it('should allow adding tables', function()
      opt.wildignore = 'foo'
      eq(vim.o.wildignore, 'foo')

      opt.wildignore = opt.wildignore + { 'bar', 'baz' }
      eq(vim.o.wildignore, 'bar,baz,foo')
    end)

    it('should not allow adding duplicates', function()
      opt.wildignore = 'foo'
      eq(vim.o.wildignore, 'foo')

      opt.wildignore = opt.wildignore + { 'bar', 'baz' }
      eq(vim.o.wildignore, 'bar,baz,foo')

      opt.wildignore = opt.wildignore + { 'bar', 'baz' }
      eq(vim.o.wildignore, 'bar,baz,foo')
    end)

    it('should allow adding multiple times', function()
      opt.wildignore = 'foo'
      opt.wildignore = opt.wildignore + 'bar' + 'baz'
      eq(vim.o.wildignore, 'bar,baz,foo')
    end)

    it('should remove values when you use minus', function()
      opt.wildignore = 'foo'
      eq(vim.o.wildignore, 'foo')

      opt.wildignore = opt.wildignore + { 'bar', 'baz' }
      eq(vim.o.wildignore, 'bar,baz,foo')

      opt.wildignore = opt.wildignore - 'bar'
      eq(vim.o.wildignore, 'baz,foo')
    end)

    describe('key:value style options', function()
      it('should handle dictionary style', function()
        opt.listchars = {
          eol = "~",
          space = ".",
        }
        eq(vim.o.listchars, "eol:~,space:.")
      end)

      it('should allow adding dictionary style', function()
        opt.listchars = {
          eol = "~",
          space = ".",
        }

        opt.listchars = opt.listchars + { space = "-" }
        eq(vim.o.listchars, "eol:~,space:-")
      end)

      it('should allow adding dictionary style', function()
        opt.listchars = {
          eol = "~",
          space = ".",
        }

        opt.listchars = opt.listchars + { space = "-" } + { space = "_" }
        eq(vim.o.listchars, "eol:~,space:_")
      end)

      it('should allow completely new keys', function()
        opt.listchars = {
          eol = "~",
          space = ".",
        }

        opt.listchars = opt.listchars + { tab = ">>>" }
        eq(vim.o.listchars, "eol:~,space:.,tab:>>>")
      end)

      it('should allow subtracting dictionary style', function()
        opt.listchars = {
          eol = "~",
          space = ".",
        }

        opt.listchars = opt.listchars - "space"
        eq(vim.o.listchars, "eol:~")
      end)

      it('should allow subtracting dictionary style', function()
        opt.listchars = {
          eol = "~",
          space = ".",
        }

        opt.listchars = opt.listchars - "space" - "eol"
        eq(vim.o.listchars, "")
      end)
    end)
  end)
end)
