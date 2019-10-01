#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `osxprep.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Step 1: Update the OS and Install Xcode Tools
echo "------------------------------"
echo "Install zsh"
# clone vimrc repo.
cd
git clone git@github.com:r4ravi2008/oh-my-zsh.git ~/.oh-my-zsh
cd .oh-my-zsh
cp .zshrc ~/
chsh -s $(which zsh)

# install zsh-autosuggestions and syntax highlighting, need to install them after zsh is installed, hence we are cloning now.
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions