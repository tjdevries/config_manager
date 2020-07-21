---
title: Design Principles of Lua
author: TJ DeVries
date: 2020-06-19
---

# History

- First released in 1993
- Created in Brazil
- Commonly used in scripting games / (other stuff?)
    - Also in AI / ML libraries / engines.

# Goal

TODO: Bullet points, not blob of text

The goal of this presentation is not that when you're done, you're able to write anything you can imagine in Lua. The goal is instead, that when you're writing and learning about Lua and you encounter something new, you're able to answer the question: "Why does Lua make this decision?" -- even if you might disagree with it :)

# Motto

> Mechanisms instead of policies

- Policy
    - Methodical way of using existing mechanism to build a new abstraction.

    - TODO: It would be nice to do a better one than this...?
    - Example: Encapsulation in C with `.h` and `.c`
        - The ISO C specification offers no mechanism for modules or interfaces.

# Motto

> Mechanisms instead of policies

- Lua has replaced many different features by creating a few simple mechanisms

> A design model that is "economical in concepts"

- One general mechanism for major aspects of programming
    - Data        :: Tables
    - Abstraction :: Function
    - Coroutines  :: Control

# Goals

- Simplicity
- Small Size
- Portability
- Embeddability

- (LuaJit) Speed

# Goals

## Simplicity

Add a few powerful *mechanisms* that can address several different needs.

This precludes adding many *policies* (language specific constructs) for every imaginable need.

**Result**:

- Lua reference manual is very small (about 100 pages) and covers the entire language, standard libraries and C API.

# Goals

## Small Size

Binary size for Linux is around 200 KB.

Allows host programs, like Neovim, to ship with almost no new "bloat".

# Goals

## Portability

Lua(JIT) are implemented in ISO C. 

Coupled with the fact that Lua can load with as little as 300 KB of memory, you can run Lua basically anywhere.
- Inside OS Kernels
- Mainstream systems
- Mainframes
- Bare metal

# Goals

## Embeddability

Embeddable in both ways:
- Extend
    - Allow re-using foreign languages within Lua
        - `vim.fn` in Neovim
- Embed
    - Implementing features in Lua, and controlling them from a host.
        - Writing a function in Lua with complicated business logic, and calling it from your C-based program.

**Key**: Mechanisms exposed as functions are naturally mapped to the API.

# Goals

## (LuaJIT) Speed

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

[ref] https://github.com/tjdevries/vim9jit
[ref] https://luajit.org/performance_x86.html

# Types

- 8 Types:
    - nil
    - boolean
    - number
    - string
    - userdata
    - table
    - function
    - thread

# Types: table

Tables are the only way to store "data" in Lua.

They can be used for low-level constructs:
- maps, arrays, sets, records

They can also be used for high-level constructs:
- modules, objects, environments

**Note**: Arrays have no special status in Lua. They are just tables with numbers as the keys, rather than strings or some other data type. As opposed to Python, for example, which has different semantics for `[]` vs `{}`

# Types: function

In Lua, functions are first-class anonymous functions with lexical scoping.

- **first-class**
    - Functions can be stored as variables, can be returned from functions and can be passed into other functions.
- **anonymous**
    - Functions do not have a name. Although when writing a function like this:

```lua
-- Appears to be named...
function add(x, y) return x + y end

-- ... but actually just syntactic sugar for this:
add = function(x, y) return x + y end
```

- **lexical scoping**
    - Informally known as closures.

```lua
local x = 5
function do_stuff(arg) return x + arg end
```

# Types: thread

Link to norcalli's forthcoming article on coroutines.

# Example of Mechanisms vs. Policies

## Objects

Part 1: Metatables

```lua
local mt = {}

function newVector (x, y)
    local p = {x = x, y = y}
    setmetatable(p, mt)
    return p
end

function mt.__add (p1, p2)
    return newVector(p1.x + p2.x, p1.y + p2.y)
end

-- example of use
A = newVector(10, 20)
B = newVector(20, -40)
C = A + B
print(C.x, C.y)
--> 30
-20
```
# Example of Mechanisms vs. Policies

## Objects

Part 2: Syntactic Sugar

```lua
local Account = {balance = 0}
local account_mt = { __index = Account }

function Account:new()
    return setmetatable({}, account_mt)
end

function Account:desposit(amount)        -- -> Account.deposit(self, amount)
    self.balance = self.balance + amount
end

local a = Account:new()                  -- -> Account.new(Account)

a:deposit(100)                           -- -> a.deposit(a, 100)
print(a.balance)                         -- -> 100
```

# Example of Mechanisms vs. Policies

## Modules and Namespacing

```lua
local mymodule = require('mymodule')
```

TODO: Write this part...

# Example of Mechanisms vs. Policies

## Error Handling

In many languages, there is a special and semantic way to do error handling. This often involves some sort of `try/catch` combination.

Lua does not have this policy.

Reasons:
- It is difficult to map this idea neatly into the Lua-C API for embedding / extending.
- It is sometimes difficult to discern what should happen if an error occurs within a `catch` statement for a particular `try/catch` pair.

# Example of Mechanisms vs. Policies

## Error Handling

Replacement:

The higher order function `pcall` (or in the Lua-C API, `lua_pcall`) takes a function and attempts to execute it. If the function succeeds, it will return `true` and any associated return values. If the function encounters an error, it will return `false` and the associated `error` message.

```lua
local ok, err_msg = pcall(function() ... end)
if not ok then
  print("TERMINATED: ERROR = ", err_msg)
  return
end
```

A nice result of this, is that it is obvious what should happen when an error occurs outside of a `pcall` -- it should be thrown.

# Tradeoffs

- Lua does not ship with a vast library of non-portable extensions:
    - Date & time manipulation (because they are the worst things in the world to work with obviously)
        - Side note: timezones should be eliminated
        - So no high precision timers in base lua, for example.

- Language complexity is limited by the ability to express it via the Lua-C API.
    - No operators like `+=`. Multiple reasons:
        - Difficult to write this exact thing inside of the stack-based Lua-C API.
        - It doesn't play nice with multiple assignment:
            - What should `a, b, c += MyFunction()` do?
        - How many times should the keys be looked up in `my_table.x += 1`. Once or twice?
            - Obvious    : `my_table.x = my_table.x + 1`
            - Not Obvious: `my_table.x += 1`

TODO: There are probably a few other important tradeoffs that we should add.

# Pros

- The host can sandbox Lua execution:
    - Control the computation time 
    - Control the functions included
    - No ability to require external modules / libraries
    - Ability to prevent any `IO`


TODO: Should mention that it's garbage collected.
- It makes it significantly easier to write than C
- It also has strings that nice.
TODO: Some other general negatives? (like, numbers are all floats I think?)
TODO: Mechanism & policy stuff is not super clear. SHould spend some times polishing and making simple
TODO: Maybe move mech & policy to after simplicity

Because of being designed, in some ways, for non-programmers
TODO: Arrays at 1
