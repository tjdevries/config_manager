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

link_neovim() {
    # Link neovim to be an alias. I don't really use this right now
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --config vi
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    sudo update-alternatives --config editor
}

link_neovim_files() {
    mkdir -p ~/.config
    ln ~/.vim ~/.config/nvim
    ln -sf $(pwd)/.vimrc ~/.config/nvim/init.vim
    ln -sf $(pwd)/.nvimrc ~/.config/nvim/.nvimrc
    ln -sf $(pwd)/ftplugin/* ~/.config/nvim/ftplugin/
}

# Install Neovim
install_neovim() {
    printEqual "Begin: Installing Neovim"
    sudo apt-get install software-properties-common -y

    sudo apt-get install python-dev python-pip python3-dev python3-pip -y
    sudo pip3 install neovim --upgrade

    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install neovim -y

    printEqual "Done : Installing Neovim"

    printEqual "Begin: Linking config files"
    link_neovim_files
    printEqual "Done : Linking config files"

    printEqual "Begin: Installing Neovim peripherals"
    install_vimplug
    printEqual "Done : Installing Neovim peripherals"
}
