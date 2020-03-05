#!/bin/bash

set -e
set -x


# {{{ Python tools

if ! [ -x "$(command -v pyenv)" ]; then
	curl https://pyenv.run | bash
fi

directory="$(pyenv root)/plugins/pyenv-default-packages" 
if ! [ -d $directory ]; then
	git clone https://github.com/jawshooah/pyenv-default-packages.git $directory
fi

# Link the default packages to the right location
if ! [ -f "$(pyenv root)/default-packages" ]; then
	ln -s "$XDG_CONFIG_HOME/pyenv/default-packages" "$(pyenv root)/default-packages"
fi

# Update any packages required.
pyenv update

# }}}

# {{{ Rust tools
# Check that rust is installed... otherwise should run this
if ! [ -x "$(command -v cargo)" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

cargo install \
	git-trim \
	ripgrep

# }}}
