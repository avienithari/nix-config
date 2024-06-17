#!/usr/bin/env bash

sudo apt-get install ninja-build gettext cmake unzip curl build-essential git
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
