## Neovim configuration

Uses vim-plug to manage plugins.

The structure looks like this:

`init.vim` sources everything in the `init/` folder. You can find configuration for individual items in that folder.

There are also some fun things in other locations.

### Useful plugins

#### Denite.vim

`,en` - Open configuration files
`,er` - Open recent files
`,ir` - Open currently opened files

#### Colorbuddy

This is a cool plugin I wrote to manage colorschemes.

You can see it in:

`colors/gruvbuddy.lua`

The main gist is that you can make Groups and Colors, and use them (with styles) to inherit from other groups and update those live. You can also make them lighter or darker compared to a parent group.
