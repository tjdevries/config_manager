#!/bin/bash

printEqual () {
    echo "=============================================================="
    echo "    $1"
    echo "=============================================================="
} 

# Install our new plugin manager
install_vimplug() {
    # Install vim-plug
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

# Install Neovim
install_neovim() {
    sudo apt-get install software-properties-common

    sudo apt-get install python-dev python-pip python3-dev python3-pip

    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install neovim

    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --config vi
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    sudo update-alternatives --config editor

    mkdir -p ~/.config
    ln ~/.vim ~/.config/nvim
    ln -s ~/.vimrc ~/.config/nvim/init.vim

    install_vimplug
}
