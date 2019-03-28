#!/bin/bash

echo "Linking install files"
ln -svf $(pwd)/nvim $CONFIG_HOME
ln -svf $(pwd)/zsh $CONFIG_HOME
ln -svf $(pwd)/home/* $HOME
ln -svf $(pwd)/git/.gitconfig $HOME/.gitconfig

echo "Install zplug"
curl -sL zplug.sh/installer | zsh
