---
title: Design Principles of Lua
author: TJ DeVries
date: 2020-09-05
---

# Introduction

# Goal

What this presentation is about:
- When writing Lua and you encounter something new, you're able to answer the question:

> "Why does Lua make this decision?"
>
> [ even if you might disagree with it :) ]

- And after understanding that, hopefully you'll understand why Lua is a great choice for Neovim.

# Goal

What this presentation is **not** about:
- Comprehensive guide to syntax and writing Lua
- Step-by-step guide on creating a Lua plugin for Neovim

# Goal

Good learning resources:

- Lua Plugins: https://github.com/nanotee/nvim-lua-guide
- Lua: https://learnxinyminutes.com/docs/lua/
- Lua: http://www.lua.org/pil/contents.html
- Lua: http://nova-fusion.com/2012/08/27/lua-for-programmers-part-1-language-essentials/

# History

> Lua is powerful (but simple).

- First released in 1993
- Created in Brazil
- Commonly used in scripting / games / embedding
    - Also in AI / ML libraries / engines.

# Motto

Lua
> Mechanisms instead of policies


Neovim
> Strong defaults and extensibility, choose two.

# Motto

> Mechanisms instead of policies

- Lua provides many "meta-mechanisms" to implement features.
    - Does not provide every feature "built-in" to the language

- For example, `tables` (associate arrays) can be used simply and efficiently to:
    - modules
    - prototype-based objects
    - class-based objects,
    - records,
    - arrays,
    - sets,
    - bags,
    - lists,
    - ... etc :)

# Motto

> Mechanisms instead of policies


```python
# Python: special keywords for each policy.

class Vector:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __add__(self, other):
        return Vector(self.x + other.x, self.y + other.y)
```

# Motto

> Mechanisms instead of policies

```lua
-- Lua: Implement "Objects" with built-in mechanisms

getNewVector = function(x, y)
    local p = {x = x, y = y}
    setmetatable(p, {
        __add = function(p1, p2)
            return getNewVector(p1.x + p2.x, p1.y + p2.y)
        end
    })
    return p
end

A = getNewVector(10, 20)
B = getNewVector(20, -40)
C = A + B
print(C.x, C.y)
-- > 30
-- > -20
```

# Lua's Goals

You can see the influence of the motto in the following goals.

- Simplicity
- Small Size
- Portability
- Embeddability

- (LuaJit) Speed

# Lua's Goals

## Simplicity

Add a few powerful *mechanisms* that can address several different needs.

This precludes adding many *policies* (language specific constructs) for every imaginable need.

**Result**:

- Lua reference manual is very small
    - About 100 pages
    - Covers the entire language, standard libraries and C API.
    - Allows people to get started quickly with Lua

# Lua's Goals

## Small Size

- Binary size for Linux = ~200 KB.

Allows host programs, like Neovim, to ship with almost no new "bloat".

**Result**:

- Standard library is very small compared to other languages, especially when combined with...

# Lua's Goals

## Portability

Lua is implemented in ISO C.

Coupled with the fact that Lua can load with as little as 300 KB of memory, you can run Lua basically anywhere.
- Inside OS Kernels
- Mainstream systems
- Mainframes
- Bare metal

**Result**:

- Good luck writing a datetime library in ISO C that can load in an OS Kernel ;)

# Lua's Goals

## Embeddability

Lua is both:
- an _extension_ language
- an _extensible_ language

# Lua's Goals

## Embeddability

- an _extension_ language
    - Implementing features in Lua, and controlling them from a host.
        - Write complex business logic in Lua => Call it from your C-based program.
        - Expose an API for modding a video game.
    - Neovim:
        - Lua functions can be passed to be executed **inside of vimscript**

```vim
let LuaMapper = luaeval('function(k, v) return k .. ":" .. v end')
echo map(['a', 'b', 'c'], LuaMapper)
" => ['0:a', '1:b', '2:c']
```

# Lua's Goals

## Embeddability

- an _extensible_ language
    - Allow re-using foreign languages within Lua
        - `vim.fn` in Neovim.
            - vimscript functions in Lua!
            - Even User (autoload, script-local, etc.) vimscript functions!

```lua
print(vim.fn.fnamemodify("/home/tj/.config/nvim/init.vim", ":h"))
-- /home/tj/.config/nvim
```

**Key**: Mechanisms exposed as functions are naturally mapped to the API.

# Lua(JIT)'s Goals

## Vim Speed

```vim
function VimNew()
  let sum = 0
  for i in range(1, 2999999)
    let sum = sum + i
  endfor

  return sum
endfunction

" 5.511384
```

# Lua's Goals

## LuaJIT Speed

```lua
local function VimNew()
  local sum = 0
  for i = 1, 2999999, 1 do
    sum = sum + i
  end


  return sum
end

-- 0.002904
```

[ref] https://github.com/tjdevries/vim9jit

[ref] https://luajit.org/performance_x86.html

# Ok... I see the goals. How does it happen?



# Simple Types

- 8 Types:
    - nil
    - boolean
    - number
    - string
    - userdata
    - table
    - function
    - thread


# Motto

> Mechanisms instead of policies

- Lua has replaced many different features by creating a few simple mechanisms

> A design model that is "economical in concepts"

- One general mechanism for major aspects of programming
    - Data        :: Tables
    - Abstraction :: Function
    - Control     :: Coroutines

# Types: table

Tables are the only way to store "data" in Lua.
- Tables can store any values key or value

# Types: table

They can be used for low-level constructs:
- maps, arrays, sets, records

**Note**: Arrays have no special status in Lua.
- They are just tables with numbers as the keys
- Different from other languages (like Python) which has different semantics for `[]` vs `{}`

# Types: table

They can also be used for high-level constructs:
- modules, objects, environments

# Types: table

## Syntactic Sugar To Interact With Tables.

Another way to implement Object-Oriented programming in Lua.

```lua
local Account = {}
Account.__index = Account

function Account:new()                   --> function Account.new(self)
    return setmetatable({
        balance = 0,
    }, self)
end

function Account:desposit(amount)        --> function Account.deposit(self, amount)
    self.balance = self.balance + amount
end

local a = Account:new()                  --> Account.new(Account)

a:deposit(100)                           --> a.deposit(a, 100)
print(a.balance)                         --> 100
```

NOTE: This method maps very well to the C API!

# Types: function

In Lua, functions are first-class anonymous functions with lexical scoping.


# Types: function

In Lua, functions are first-class anonymous functions with lexical scoping.

- **first-class**
    - Functions can be stored as variables, can be returned from functions and can be passed into other functions.

# Types: function

In Lua, functions are first-class anonymous functions with lexical scoping.

- **anonymous**
    - Functions do not have a name. Although when writing a function like this:

```lua
-- Appears to be named...
function add(x, y) return x + y end

-- ... but actually just syntactic sugar for this:
add = function(x, y) return x + y end
```

# Types: function

In Lua, functions are first-class anonymous functions with lexical scoping.

- **lexical scoping**
    - Informally known as closures.

```lua
local x = 1

function do_stuff(arg) return x + arg end

do_stuff(10)  --> 11

x = 5
do_stuff(10)  --> 15
```

# Types: function

## Error Handling

In many languages, there is a special and semantic way to do error handling.
- `try` / `catch`
- `try` / `except`

Lua does not have this policy.

Reasons:
- Embedding: Difficult to map to Lua C-API
- Simplicity: Difficult to determine behavior if error in `catch` section

# Types: function

## Error Handling In Lua

Replacement:

- Re-use function mechanism: `pcall`:
    - Higher order function.
    - Attempts to execute given argument.
    - returns `true, ...` if success.
    - returns `false, err_msg` if failure.

```lua
-- Attempt to call `vim._update_package_paths`

local ok, err_msg = pcall(vim._update_package_paths)
if not ok then
  print("E5117: Error while updating package paths:", err_msg)
  return
end
```

# Example of Mechanisms vs. Policies

## Error Handling In C

```c
static lua_State *nlua_enter(void)
  FUNC_ATTR_NONNULL_RET FUNC_ATTR_WARN_UNUSED_RESULT
{
  // ...
  static const void *last_p_rtp = NULL;
  if (last_p_rtp != (const void *)p_rtp) {
                                                         // stack: (empty)
    lua_getglobal(lstate, "vim");                        // stack: vim
    lua_getfield(lstate, -1, "_update_package_paths");   // stack: vim, vim._update_package_paths
    if (lua_pcall(lstate, 0, 0, 0)) {                    // stack: vim, error
      nlua_error(lstate, _("E5117: %.*s"));              // stack: vim
    }
                                                         // stack: vim
    lua_pop(lstate, 1);                                  // stack: (empty)
    last_p_rtp = (const void *)p_rtp;
  }
  // ...
}
```


# Types: thread

A `thread` is the type of a `coroutine` in Lua.
- No new syntax is required, Lua ships with the `coroutine` library to manage coroutines.
- Coroutines are asymmetric.
    - Different functions to suspend and resume execution.

# Types: thread

Quick example. For recommended reading: https://www.lua.org/pil/9.1.html

```lua
-- each `character` represents a thread with some state.
-- this is an (naive) example of how a game loop could be implemented.
local my_characters = {thread_1, thread_2, thread_3}

do
    for index, character in ipairs(my_characters) do
        if coroutine.status(co) == 'dead' then
            table.remove(index)
        else
            coroutine.resume(character)
        end
    end

    if #my_characters == 0 then
        break
    end
while true
```


# Tradeoffs

 ARRAYS ARE 1-INDEXED ARRAYS ARE 1-INDEXED ARRAYS ARE 1-INDEXED

 ARRAYS ARE 1-INDEXED ARRAYS ARE 1-INDEXED ARRAYS ARE 1-INDEXED

 ARRAYS ARE 1-INDEXED ARRAYS ARE 1-INDEXED ARRAYS ARE 1-INDEXED

 ARRAYS ARE 1-INDEXED ARRAYS ARE 1-INDEXED ARRAYS ARE 1-INDEXED

 ARRAYS ARE 1-INDEXED ARRAYS ARE 1-INDEXED ARRAYS ARE 1-INDEXED

 ARRAYS ARE 1-INDEXED ARRAYS ARE 1-INDEXED ARRAYS ARE 1-INDEXED

_ _

 (but it's really not that big of a deal once you get started)

# Tradeoffs

- Language complexity is limited by the ability to express it via the Lua-C API.
    - No operators like `+=`. Multiple reasons:
        - Difficult to write this exact thing inside of the stack-based Lua-C API.
        - It doesn't play nice with multiple assignment:
            - What should `a, b, c += MyFunction()` do?
        - How many times should the keys be looked up in `my_table.x += 1`. Once or twice?
            - Obvious    : `my_table.x = my_table.x + 1`
            - Not Obvious: `my_table.x += 1`
    - However:
        - **Neovim**: People want to configure their editor, not learn a language.


# Tradeoffs

- Lua does not ship with a vast library of non-portable extensions:
    - Date & time manipulation (because they are the worst things in the world to work with obviously)
        - So no high precision timers in base lua, for example.
    - However:
        - **Neovim**: We're able to ship with a standard library of functions for Lua


# Pros

- The host can sandbox Lua execution:
    - Control the computation time
    - Control the functions included
    - No ability to require external modules / libraries
    - Ability to prevent any `IO`

# Pros

- It makes plugins / extensions / customizations significantly easier to write than C
    - It is garbage collected.
    - It also has strings, so that's nice :)
    - (and all the other reasons it is hard to write C)
    - Makes it a lot easier to write extensions and business logic than extending

# Pros

- It is a widely used language:
    - Fast
    - Safe
    - Libraries exist
    - Useful outside of Neovim

# Conclusion

- Neovim chose Lua because:
    - Simplicity
    - Small Size
    - Portability
    - Embeddability
    - Speed

# Contact Me

- Presentation: https://github.com/tjdevries/config_manager (in presentations)



- Github : https://github.com/tjdevries
- Twitch : https://twitch.tv/teej_dv
- Tiwtter: https://twitter.com/TeejDeVries

