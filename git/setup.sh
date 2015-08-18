#!/bin/bash

# Install git
if [ ! $(which git) ]
then
    sudo apt-get install -y git
fi

# Set global configs for git
git config --global user.name "TJ DeVries"
git config --global user.email "timothydvrs1234@gmail.com"
git config --global push.default simple

