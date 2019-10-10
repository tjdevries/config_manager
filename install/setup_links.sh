#! /bin/bash

set -e

mv ~/.config ~/_temp_config
ln -s ~/git/config_manager/xdg_config ~/.config
cp -r ~/_temp_config/* ~/.config/
rm -rf ~/_temp_config

# Home files
ln -s ~/git/config_manager/home/.zshenv ~/.zshenv
