#!/bin/bash

set -e
set -x

mkdir -p ~/build
mkdir -p ~/git

if ! command -v gh &> /dev/null ; then
    # sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
    # sudo apt-add-repository https://cli.github.com/packages
fi

sudo apt update

sudo apt-get install -y \
    make cmake git \
    gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip \
    make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev git

if ! [ -d $HOME/build/neovim ]; then
    git clone https://github.com/neovim/neovim ~/build/neovim
    cd ~/build/neovim/
    make
    sudo make install
fi

# {{{ Python tools

if ! [ -d $HOME/.pyenv ]; then
  curl https://pyenv.run | bash
fi

# I don't really like having the default packages now.
# directory="$(pyenv root)/plugins/pyenv-default-packages" 
# if ! [ -d $directory ]; then
#   git clone https://github.com/jawshooah/pyenv-default-packages.git $directory
# fi

# Link the default packages to the right location
# if ! [ -f "$(pyenv root)/default-packages" ]; then
#   ln -s "$XDG_CONFIG_HOME/pyenv/default-packages" "$(pyenv root)/default-packages"
# fi

# Update any packages required.
# pyenv update

# }}}

# {{{ Rust tools
# Check that rust is installed... otherwise should run this
if ! [ -x "$(command -v cargo)" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! command -v rust_analyzer &> /dev/null ; then
    git clone https://github.com/rust-analyzer/rust-analyzer ~/build/rust-analyzer
    cd ~/build/rust-analyzer
    cargo xtask install --server
fi

cargo install \
  git-trim \
  ripgrep \
  broot \
  watchexec-cli \
  starship

if ! [ -d ~/build/delta ]; then
  git clone https://github.com/dandavison/delta ~/build/delta

  cd ~/build/delta
  cargo install --path .
fi


# Alacritty
# TODO: Disable this and switch to kitty, since it seems to play better for me for some reason
# if ! [ -d ~/build/alacritty/ ];  then
#   sudo apt install -y \
#     cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3

#   git clone https://github.com/alacritty/alacritty.git ~/build/alacritty
#   # Not sure about this command...
#   $(cd ~/build/alacritty/; cargo build --release; cargo install --path alacritty alacritty)
# fi

# }}}

# {{{ Zsh
sudo apt install zsh

# if ! [ -d $HOME/.config/oh-my-zsh/ ]; then
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# fi

# if ! [ -d "$ZSH_CUSTOM/themes/spaceship-prompt" ]; then
#   git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
#   ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
# fi
# }}}

# Github
sudo apt install gh

if ! command -v kitty &> /dev/null ; then
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
fi
