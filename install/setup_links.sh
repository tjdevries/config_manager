#! /bin/bash

set -x

if [[ -d "$HOME/.config" ]]; then
    MOVE_CONFIG=true
fi

if [[ $MOVE_CONFIG ]]; then
    echo "Moving config"
    mv ~/.config ~/_temp_config
fi

ln -sv ~/git/config_manager/xdg_config/ ~/.config

if [[ $MOVE_CONFIG ]]; then
    cp -r ~/_temp_config/* ~/.config/
    rm -rf ~/_temp_config
fi

# Home files
if [[ -f "~/.zshenv" ]]; then
    ln -vs ~/git/config_manager/home/.zshenv ~/.zshenv
fi
