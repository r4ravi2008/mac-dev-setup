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
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew install homebrew/php/php55 --with-gmp
brew install kubectl
brew tap aws/tap
brew install aws-sam-cli
brew install openssh

# Install other useful binaries.
brew install git
brew install git-lfs
brew install git-flow
brew install git-extras
brew install ssh-copy-id
brew install cmake
brew install maven
brew install npm
brew install adns
brew install ansible
brew install apache-spark
brew install argocd
brew install autoconf
brew install autojump
brew install automake
brew install aws-sam-cli
brew install aws-shell
brew install awscli
brew install berkeley-db
brew install cairo
brew install coreutils
brew install cscope
brew install docker
brew install emacs-plus --with-jansson --with-emacs-27-branch --HEAD
brew install exif
brew install exiftool
brew install fish
brew install fontconfig
brew install fpp
brew install freetype
brew install fribidi
brew install fzf
brew install gd
brew install gdbm
brew install gdk-pixbuf
brew install gettext
brew install ghostscript
brew install git-extras
brew install git-flow
brew install git-lfs
brew install glib
brew install gmime
brew install gmp
brew install gnupg
brew install gnutls
brew install gpgme
brew install graphite2
brew install graphviz
brew install gts
brew install harfbuzz
brew install haskell-stack
brew install htop
brew install icu4c
brew install ilmbase
brew install imagemagick
brew install imagemagick@6
brew install ispell
brew install isync
brew install jansson
brew install jasper
brew install jpeg
brew install jq
brew install krb5
brew install kubernetes-cli
brew install ldns
brew install libassuan
brew install libcroco
brew install libde265
brew install libevent
brew install libexif
brew install libffi
brew install libgcrypt
brew install libgpg-error
brew install libheif
brew install libidn2
brew install libksba
brew install libomp
brew install libpng
brew install librsvg
brew install libssh2
brew install libtasn1
brew install libtermkey
brew install libtiff
brew install libtool
brew install libunistring
brew install libusb
brew install libuv
brew install libvterm
brew install libxml2
brew install libyaml
brew install little-cms2
brew install lua
brew install luajit
brew install lzo
brew install maven
brew install msgpack
brew install mu
brew install navi
brew install ncurses
brew install neovim
brew install netpbm
brew install nettle
brew install nikto
brew install node
brew install npth
brew install nspr
brew install nss
brew install oniguruma
brew install openexr
brew install openjpeg
brew install openssh
brew install openssl@1.1
brew install p11-kit
brew install packer
brew install pandoc
brew install pango
brew install pcre
brew install pcre2
brew install perl
brew install pinentry
brew install pixman
brew install pkg-config
brew install poppler
brew install popt
brew install postgresql
brew install python3
brew install qt
brew install readline
brew install ripgrep
brew install ruby
brew install sbt
brew install scala
brew install shared-mime-info
brew install spark
brew install sqlite
brew install ssh-copy-id
brew install terraform
brew install texinfo
brew install tmux
brew install unbound
brew install unibilium
brew install vim
brew install webp
brew install wget
brew install x265
brew install xapian
brew install xz
brew install zeromq
brew install zsh

#casks
brew cask install --appdir="/Applications" alfred
brew cask install --appdir="~/Applications" iterm2
brew cask install --appdir="~/Applications" java
brew cask install --appdir="~/Applications" xquartz
brew cask install --appdir="~/Applications" docker
brew cask install adoptopenjdk8
brew cask install basictex
brew cask install --appdir="/Applications" chromedriver
brew cask install --appdir="/Applications" docker
brew cask install --appdir="/Applications" kitty
brew cask install --appdir="/Applications" platypus
brew cask install --appdir="/Applications" xquartz

#cleanup
brew cleanup
