#!/bin/bash

# First we need to install pathogen
if [ ! -d ~/.vim/autoload ]; then
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
        curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

# Install syntastic
if [ ! -d ~/.vim/bundle/syntastic ]; then
    git clone https://github.com/scrooloose/syntastic   ~/.vim/bundle/syntastic
fi


# Install vim-sensible
if [ ! -d ~/.vim/bundle/vim-sensible ]; then
    git clone git://github.com/tpope/vim-sensible.git ~/.vim/bundle/vim-sensible 
fi

# Install vim-airline
if [ ! -d ~/.vim/bundle/vim-airline ]; then
    git clone https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline
fi

# Install tabular
if [ ! -d ~/.vim/bundle/tabular ]; then
    git clone https://github.com/godlygeek/tabular ~/.vim/bundle/tabular
fi

# Install vim-markdown
if [ ! -d ~/.vim/bundle/vim-markdown ]; then
    git clone https://github.com/plasticboy/vim-markdown    ~/.vim/bundle/vim-markdown
fi

# Install vim-autoclose
if [ ! -d ~/.vim/bundle/vim-autoclose ]; then
    git clone git://github.com/Townk/vim-autoclose  ~/.vim/bundle/vim-autoclose
fi

# Install color schemes
if [ ! -d ~/.vim/bundle/vim-colors-solarized  ]; then
    git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
fi

# The python one doesn't work any more
# sudo pip3 install powerline-status

# if [ "$lvim --version | grep +python)" ]; then
#        echo "Has python support"
#        fi
 
