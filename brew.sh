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
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

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
brew install vim
brew install zsh
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew install homebrew/php/php55 --with-gmp
brew install kubectl
brew install tmux
brew install awscli
brew install aws-shell

# Install other useful binaries.
brew install git
brew install git-lfs
brew install git-flow
brew install git-extras
brew install ssh-copy-id
brew install cmake
brew install maven
brew install npm

# Core casks
brew cask install --appdir="/Applications" alfred
brew cask install --appdir="~/Applications" iterm2
brew cask install --appdir="~/Applications" java
brew cask install --appdir="~/Applications" xquartz

# Misc casks
# brew cask install --appdir="/Applications" google-chrome
# brew cask install --appdir="/Applications" firefox
#brew cask install --appdir="/Applications" skype
# brew cask install --appdir="/Applications" slack
# brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="/Applications" evernote
# brew cask install --appdir="/Applications" 1password
#brew cask install --appdir="/Applications" gimp
#brew cask install --appdir="/Applications" inkscape
 brew cask install google-cloud-sdk

#Remove comment to install LaTeX distribution MacTeX
#brew cask install --appdir="/Applications" mactex

# Install Docker, which requires virtualbox
brew install docker
# brew install boot2docker
# Remove outdated versions from the cellar.
brew cleanup