# Things to do in Nvim


## Shortcuts I like from PyCharm

```
- <C-Space><C-Space>
    - Complete from anywhere
- <C-J>
    - Complete snippets (Live Templates)
    - Should make the same snippets I have in PyCharm, so that things are easier.
- <C-A-O>
    - Optimize imports
    - Sorts & Optimizes
- <A-Enter>
    - "Fix" something
    - Would be nice to just have a chain of possibilities
    - Import this, spell this, etc.
```

```
From vim-surround

                                                *i_CTRL-G_s* *i_CTRL-G_S*
Finally, there is an experimental insert mode mapping on <C-G>s and <C-S>.
Beware that the latter won't work on terminals with flow control (if you
accidentally freeze your terminal, use <C-Q> to unfreeze it).  The mapping
inserts the specified surroundings and puts the cursor between them.  If,
immediately after the mapping and before the replacement, a second <C-S> or
carriage return is pressed, the prefix, cursor, and suffix will be placed on
three separate lines.  <C-G>S (not <C-G>s) also exhibits this behavior.


If f, F, or <C-F> is used, Vim prompts for a function name to insert.  The target
text will be wrapped in a function call. If f is used, the text is wrapped with
() parentheses; F adds additional spaces inside the parentheses. <C-F> inserts the
function name inside the parentheses.

  Old text                  Command           New text ~
  "hello"                   ysWfprint<cr>     print("hello")
  "hello"                   ysWFprint<cr>     print( "hello" )
  "hello"                   ysW<C-f>print<cr> (print "hello")
```
