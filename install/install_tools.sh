#!/bin/bash

set -e
set -x


sudo apt update
sudo apt upgrade

sudo apt-get install -y make cmake git

# Neovim dependencies
sudo apt-get install -y gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

# Pyenv depdendencies
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git


# {{{ Python tools

if ! [ -d $HOME/.pyenv ]; then
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

# {{{ Zsh
if ! [ -d $HOME/.config/oh-my-zsh/ ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if ! [ -d "$ZSH_CUSTOM/themes/spaceship-prompt" ]; then
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi
# }}}
