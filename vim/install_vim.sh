#!/bin/bash

# First we need to install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install vim-sensible
cd ~/.vim/bundle && \
    git clone git://github.com/tpope/vim-sensible.git

# Install vim-airline
git clone https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline


# The python one doesn't work any more
# sudo pip3 install powerline-status

# if [ "$lvim --version | grep +python)" ]; then
#        echo "Has python support"
#        fi
 
