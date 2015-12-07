#!/bin/bash

printEqual () {
    echo "=============================================================="
    echo "    $1"
    echo "=============================================================="
}

# Check for the configuration items that we want
# if [ ! "$(vim --version | grep +python3 )" ]; then
#    # need_compile=1
#    echo "Someday you should fix the install vim"
# fi

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
}

if [ $need_compile ]; then
    # Compile vim with the things that I like
    # Get the required development packages 
    sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
        libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
        libcairo2-dev libx11-dev libxpm-dev libxt-dev -y

    # Get the required dev packages to get +
    sudo apt-get install ruby-dev python-dev python3-dev -y

    # Got to home directory and get the git repository
    cd ~
    if [ ! -d ~/vim ]; then
        
        printEqual "install_vim: Create and download vim folder"
        git clone https://github.com/b4winckler/vim
    else
        printEqual "install_vim: Vim folder already exists"
        cd ~/vim
        git fetch origin
        git reset --hard origin/master
    fi

    if [ ! -d ~/Downloads/vim-breakindent ]; then
        printEqual "install_vim: Create and download the breakindent patch"
        git clone https://github.com/drewinglis/vim-breakindent ~/Downloads/vim-breakindent
    else
        printEqual "install_vim: Break indent patch already downloaded"
        cd ~/Downloads/vim-breakindent
        git fetch origin
        git reset --hard origin/master
    fi

    cd ~/vim/src

    printEqual "install_vim: make clean"
    # Begin the make process
    sudo make clean

#    cd ~/vim
#    patch -p1 < ~/Downloads/vim-breakindent/breakindent.patch
#    cd src

    # Configuration options here
    sudo ./configure \
        --enable-perlinterp \
        --enable-python3interp=yes \
        --with-python3-config-dir="$(python3-config --configdir)" \
        --enable-rubyinterp \
        --enable-cscope \
        --enable-gui=no \
        --enable-gtk2-check \
        --enable-gnome-check \
        --with-features=huge \
        --enable-multibyte \
        --with-x \
        --with-compiledby="xorpd" \
        --prefix=/usr/local/bin \
        --with-vim-name="myvim"
        --silent \
        --cache-file="~/install_vim.log"

    sudo make
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

# Install vim-airline and make sure that we have the fonts install
if [ ! -d ~/.vim/bundle/vim-airline ] || [ ! -d ~/.fonts/ ]; then
    git clone https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline

    # After installing vim-arline, we want to get the cool fonts
    mkdir -p ~/.fonts/

    # Move into the folder and get the updated fonts
    cd ~/.fonts/
    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

    # Make it a possible font directory
    sudo mkfontscale
    sudo mkfontdir

    xset +fp ~/.fonts/

    # Update the font cache
    fc-cache -vf ~/.fonts/
fi

echo "--------------------------------------------------------------------------------"
echo "  Checking Vim Plugins: Begin "
echo "--------------------------------------------------------------------------------"


# Install tagbar
if [ ! -d ~/.vim/bundle/tagbar ]; then
    git clone https://github.com/majutsushi/tagbar ~/.vim/bundle/tagbar
fi

# Install vim-fugitive
if [ ! -d ~/.vim/bundle/vim-fugitive ]; then
    git clone https://github.com/tpope/vim-fugitive ~/.vim/bundle/vim-fugitive
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

# Install ctrlp 
if [ ! -d ~/.vim/bundle/ctrlp.vim ]; then
    git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
fi

# Install YCM
if [ ! -d ~/.vim/bundle/YouCompleteMe ]; then
    git clone https://github.com/Valloric/YouCompleteMe ~/.vim/bundle/YouCompleteMe
    
    # Enter the correct directory
    cd ~/.vim/bundle/YouCompleteMe

    # Update our third party sub modules
    git submodule update --init --recursive

    ./install.py --clang-completer --gocode-completer
fi

# Install ultisnips
if [ ! -d ~/.vim/bundle/ultisnips ]; then
    git clone https://github.com/SirVer/ultisnips ~/.vim/bundle/ultisnips
fi

# Install optional snippets
if [ ! -d ~/.vim/bundle/vim-snippets ]; then
    git clone https://github.com/honza/vim-snippets ~/.vim/bundle/vim-snippets
fi

echo "--------------------------------------------------------------------------------"
echo "  Checking Vim Plugins: Complete "
echo "--------------------------------------------------------------------------------"

# The python one doesn't work any more
# sudo pip3 install powerline-status

# if [ "$lvim --version | grep +python)" ]; then
#        echo "Has python support"
#        fi
 
