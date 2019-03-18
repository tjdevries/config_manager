
syntax keyword luaMyKeyword
      \ self

syntax keyword luaKeyword
      \ _VERSION
      \ dofile
      \ getfenv
      \ getmetatable
      \ ipairs
      \ load
      \ loadfile
      \ loadstring
      \ next
      \ pairs
      \ print
      \ rawequal
      \ rawget
      \ rawlen
      \ rawset
      \ select
      \ setfenv
      \ setmetatable
      \ tonumber
      \ tostring
      \ type
      \ unpack

syntax match luaSpecialFunctions /table\.concat/
syntax match luaSpecialFunctions /table\.foreach/
syntax match luaSpecialFunctions /table\.foreachi/
syntax match luaSpecialFunctions /table\.sort/
syntax match luaSpecialFunctions /table\.insert/
syntax match luaSpecialFunctions /table\.remove/

if v:false
    syntax match luaSpecialFunctions /string\.byte/
    syntax match luaSpecialFunctions /string\.char/
    syntax match luaSpecialFunctions /string\.dump/
    syntax match luaSpecialFunctions /string\.find/
    syntax match luaSpecialFunctions /string\.format/
    syntax match luaSpecialFunctions /string\.gmatch/
    syntax match luaSpecialFunctions /string\.gsub/
    syntax match luaSpecialFunctions /string\.len/
    syntax match luaSpecialFunctions /string\.lower/
    syntax match luaSpecialFunctions /string\.upper/
    syntax match luaSpecialFunctions /string\.match/
    syntax match luaSpecialFunctions /string\.rep/
    syntax match luaSpecialFunctions /string\.reverse/
    syntax match luaSpecialFunctions /string\.sub/
endif

syntax keyword luaMetatableEvents
    \ __index
    \ __newindex
    \ __mode
    \ __call
    \ __metatable
    \ __tostring
    \ __len
    \ __pairs
    \ __ipairs
    \ __gc

syntax keyword luaMetatableArithmetic
    \ __unm
    \ __add
    \ __sub
    \ __mul
    \ __div
    \ __mod
    \ __div
    \ __idiv
    \ __mod
    \ __pow
    \ __concat

syntax keyword luaMetatableEquivalence
    \ __eq
    \ __lt
    \ __le

syntax match luaFunctionCall display /\<\(function\)\@!\w\+(/he=e-1

