#!/bin/bash
# Build Zsh from sources on Ubuntu.
# From http://zsh.sourceforge.net/Arc/git.html and sources INSTALL file.

cd ~/Downloads

# Make script gives up on any error
set -e

# Some packages may be missing
sudo apt-get install -y git-core gcc make autoconf yodl libncursesw5-dev texinfo checkinstall

# Clone zsh repo and change to it
git clone git://git.code.sf.net/p/zsh/code zsh
cd zsh

# Get lastest stable version, but you can change to any valid branch/tag/commit id
BRANCH=$(git describe --abbrev=0 --tags)
# Get version number, and revision/commit id when this is available
ZSH_VERSION=$(echo $BRANCH | cut -d '-' -f2,3,4)
# Go to desired branch
git checkout $BRANCH

# Make configure
./Util/preconfig

# Options from Ubuntu Zsh package rules file (http://launchpad.net/ubuntu/+source/zsh)
# Updated to zsh 5.0.2 on Trusty Tahr (pre-release)
./configure --prefix=/usr \
            --mandir=/usr/share/man \
            --bindir=/bin \
            --infodir=/usr/share/info \
            --enable-maildir-support \
            --enable-max-jobtable-size=256 \
            --enable-etcdir=/etc/zsh \
            --enable-function-subdirs \
            --enable-site-fndir=/usr/local/share/zsh/site-functions \
            --enable-fndir=/usr/share/zsh/functions \
            --with-tcsetpgrp \
            --with-term-lib="ncursesw tinfo" \
            --enable-cap \
            --enable-pcre \
            --enable-readnullcmd=pager \
            --enable-custom-patchlevel=Debian \
            --enable-additional-fpath=/usr/share/zsh/vendor-functions,/usr/share/zsh/vendor-completions \
            LDFLAGS="-Wl,--as-needed -g -Wl,-Bsymbolic-functions -Wl,-z,relro"

# Compile, test and install
make -j5
make check
sudo checkinstall -y --pkgname=zsh --pkgversion=$ZSH_VERSION --pkglicense=MIT make install install.info 

# Make zsh the default shell
sudo sh -c "echo /bin/zsh >> /etc/shells"
chsh -s /bin/zsh
