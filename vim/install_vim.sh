#!/bin/bash

# Check for the configuration items that we want
if [ ! "$(vim --version | grep +python3 )" ]; then
    # This is not ready yet
    # need_compile=1
fi

if [ $need_compile ]; then
    # Compile vim with the things that I like
    # Get the required development packages 
    sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
        libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
        libcairo2-dev libx11-dev libxpm-dev libxt-dev -y

    sudo apt-get install ruby-dev python3-dev -y

    # Got to home directory and get the git repository
    cd ~
    git clone https://github.com/b4winckler/vim
    git clone https://github.com/drewinglis/vim-breakindent ~/Downloads/

    cd ~/vim
    patch -p1 < ~/Downloads/vim-breakindent/breakindent.patch

    # Begin the make process
    make distclean

    # Configuration options here
    ./configure \
        --enable-perlinterp \
        --enable-python3interp=yes \
        --with-python3-config-dir="$(python3-config --configdir)" \
        --enable-rubyinterp \
        --enable-cscope \
        --enable-gui=auto \
        --enable-gtk2-check \
        --enable-gnome-check \
        --with-features=huge \
        --enable-multibyte \
        --with-x \
        --with-compiledby="xorpd" \
        --prefix=/opt/vim74

    make
    sudo make install
fi

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
 
