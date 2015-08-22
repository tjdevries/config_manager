# Things to try at some point

## VIM

It is possible to read from other files and place the output into your buffer by doing something similiar to:

> :r *textfile*

However, this is really cool when you want to combine it with some other command. Using the command syntax of 
`:!`, one can then `:r` the command. For example:

> :r ! ls -l ~/Git

This can obviously be combined with more powerful commands, or even getting the output of custom made scripts
whenever desired. It is even possible to chain commands together

> :r ! ls -l ~/Git <bar> sort -r

This will sort the output from the expression and place that in the buffer


