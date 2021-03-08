
# Telescope FAQ

- Telescope is not 1.0 :)
- Doesn't have to be the best at everything to be a useful tool :)

- speed comparison with FZF
    - fzy-native
        - Why isn't it in core by default
    - Why not just use fzf as backend
        - The architecture isn't built like that
        - Main problem is processing all the IO without waiting for keypress
        - When we start scheduling those things, then we'll be in a much better spot.

- Why the heck would you spend time on a fuzzy finder when FZF exists?
    - Fun!
    - Push the limits of Neovim & Lua integration
    - Constraints can be interesting
    - (Selling points):
        - Lua configuration

- Why would you want to use Telescope?
    - Customize all in Lua
    - Write your own pickers
    - Every aspect is configurable
    - Builtin to Neovim
        - So it uses
    - Fun :)
