#!/bin/bash

echo "Downloading pip to download directory"
cd ~/Downloads
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
