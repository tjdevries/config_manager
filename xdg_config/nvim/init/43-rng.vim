" George Marsaglia's Multiply-with-carry Random Number Generator {{{
" Modified to work within Vim's semantics
let s:m_w = 1 + getpid()
let s:m_z = localtime()

" not sure of the wisdom of generating a full 32-bit RN here
" and then using abs() on the sucker. Feedback welcome.
function! RandomNumber(...)
  if a:0 == 0
    let s:m_z = (36969 * and(s:m_z, 0xffff)) + (s:m_z / 65536)
    let s:m_w = (18000 * and(s:m_w, 0xffff)) + (s:m_w / 65536)
    return (s:m_z * 65536) + s:m_w " 32-bit result
  elseif a:0 == 1 " We return a number in [0, a:1] or [a:1, 0]
    return a:1 < 0 ? RandomNumber(a:1,0) : RandomNumber(0,a:1)
  else " if a:2 >= 2
    return abs(RandomNumber()) % (abs(a:2 - a:1) + 1) + a:1
  endif
endfunction
" end RNG }}}

" RandomChar(base, cap)
" base : the lowest char number desired
" cap : the highest char number desired
" Defaults to ASCII characters in the range
" 33-126 (!-~)
" But it's capable of much wider character tables
function! RandomChar(...)
  let base = 33
  let cap = 126
  if a:0 > 0
    let base = a:1
  endif
  if a:0 > 1
    let cap = a:2
  endif
  return nr2char(RandomNumber(base, cap))
endfunction

function! RandomCharsInSet(length, set)
  let from = join(map(range(len(a:set)), 'nr2char(char2nr("a")+v:val)'), '')
  let to = join(a:set, '')
  return map(RandomChars(a:length, 97, 96+len(a:set)), 'tr(v:val, from, to)')
endfunction

function! RandomChars(length, ...)
  let args = []
  if a:0 > 0
    if type(a:1) == type([])
      let args = a:1
    else
      let args = a:000
    endif
  endif
  return map(repeat([0], a:length), 'call("RandomChar", args)')
endfunction

function! RandomString(length, ...)
  let args = []
  if a:0 > 0
    if type(a:1) == type([])
      let args = a:1
    else
      let args = a:000
    endif
  endif
  return join(call('RandomChars', [a:length, args]), '')
endfunction

let s:chars = '! " # $ % & '' ( ) * + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G H I J K L M N O P Q R S T U V W X Y Z [ \ ] ^ _ ` a b c d e f g h i j k l m n o p q r s t u v w x y z { | } ~'
let s:charlist = split(s:chars, ' ')

function! RandomCharFromRegex(regex, ...)
  let charlist = a:0 ? split(a:1, '\zs') : copy(s:charlist)
  call filter(charlist, 'v:val =~ a:regex')
  return charlist[RandomNumber(0, len(charlist) - 1)]
endfunction

function! RandomStringFromRegex(regex, lenght, ...)
  let charlist = a:0 ? split(a:1, '\zs') : copy(s:charlist)
  call filter(charlist, 'v:val =~ a:regex')
  let len = len(charlist) - 1
  return join(map(range(a:lenght), 'charlist[RandomNumber(0, len)]'), '')
endfunction
