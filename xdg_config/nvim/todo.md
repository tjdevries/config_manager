## TODOs

- Probably can remove `AnsiEscPlugin`, since we've got Norcalli's plugin that's better (terminal.nvim) or whatever the name is.
- Look over some of Damian Conway's old stuff in here, see if they still run and if they should get hosted somewhere else?


From vim-surround

```
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
