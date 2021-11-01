# Please, read me!

So that I can help you quickly and without having to redirect you here.

# If you have an issue

**Please read the [wiki](https://github.com/lcpz/lain/wiki) and search the [Issues section](https://github.com/lcpz/lain/issues) first.**

If you can't find a solution there, then go ahead and provide:

* output of `awesome -v` and `lua -v`
* expected behavior and actual behavior
* steps to reproduce the problem
* X error log

# How to provide X error log

There are two ways:

* (Physically) Restart X like this:
  ```shell
  startx -- -keeptty -nolisten tcp > $HOME/.xorg.log 2>&1
  ```
  the error log will be output into `$HOME/.xorg.log`.

* (Virtually) Use [Xephyr](https://wikipedia.org/wiki/Xephyr):
  ```shell
  # set screen size as you like
  Xephyr :1 -screen 1280x800 2> stdout.txt & DISPLAY=:1 awesome
  ```
  the error log will be output in the file `stdout.txt`.

Before reporting, read the log and see if you can solve it yourself.
