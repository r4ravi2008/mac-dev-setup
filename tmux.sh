#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `osxprep.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Step 1: Update the OS and Install Xcode Tools
echo "------------------------------"
echo "Install tmux configuration"
# clone vimrc repo.
cd
git clone https://github.com/r4ravi2008/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .