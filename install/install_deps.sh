mkdir -p ~/git

# git clone https://github.com/neovim/neovim > ~/git/

# Some dependencies I like
sudo apt-get install -y make cmake git


# Neovim dependencies
sudo apt-get install -y gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

wget -q -O - https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash

# Half the time, I can't get ninja-build to install
# ninja-build


# LibQt5 Requirements.
#   Mostly used for gonvim at this point, and maybe other Qt based stuff
# sudo apt-get install -y \
#     libqt5gui5 \
#     libqt5designer5 \
#     libqt5multimedia5 \
#     libqt5quick5 \
#     libqt5webchannel5 \
#     libqt5webenginewidgets5 \
#     qt5-default

# Seems like best way is to just run instaler from qt...

