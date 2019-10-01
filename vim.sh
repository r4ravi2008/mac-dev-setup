#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `osxprep.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Step 1: Update the OS and Install Xcode Tools
echo "------------------------------"
echo "Install vimrc"
# clone vimrc repo.
if [ -d ~/dev/repos ]
then
    cd ~/dev/repos
    git clone https://github.com/r4ravi2008/vimrc.git
    cd 
    ln -s -f ~/dev/repos/vimrc/.vimrc
    # install plug
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi