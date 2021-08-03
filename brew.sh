#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed

# Install `wget` with IRI support.
brew install wget --with-iri

# Install Python
# brew install python
brew install python3

# Install more recent versions of some OS X tools.
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew tap aws/tap
brew install aws-sam-cli
brew install openssh

# Install other useful binaries.
brew install git
brew install git-lfs
brew install git-extras
brew install ssh-copy-id
brew install cmake
brew install maven
brew install npm
brew install adns
brew install apache-spark
brew install autoconf
brew install autojump
brew install automake
brew install aws-sam-cli
brew install docker
brew install emacs-plus@28 --with-native-comp --with-modern-sexy-v1-icon
brew install fontconfig
brew install fzf
brew install gnupg
brew install gpgme
brew install htop
brew install jq
brew install krb5
brew install libvterm
brew install node
brew install openssh
brew install openssl@1.1
brew install pandoc
brew install postgresql
brew install python3
brew install ripgrep
brew install sbt
brew install scala
brew install sqlite
brew install ssh-copy-id
brew install tmux
brew install zsh

#casks
# brew cask install --appdir="/Applications" alfred
# brew cask install --appdir="~/Applications" iterm2
# brew cask install --appdir="~/Applications" java
# brew cask install --appdir="~/Applications" xquartz
# brew cask install --appdir="~/Applications" docker
# brew cask install adoptopenjdk8
# brew cask install basictex
# brew cask install --appdir="/Applications" chromedriver
# brew cask install --appdir="/Applications" docker
# brew cask install --appdir="/Applications" kitty
# brew cask install --appdir="/Applications" platypus
# brew cask install --appdir="/Applications" xquartz

#cleanup
brew cleanup
