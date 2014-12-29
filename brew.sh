#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Brew Install some other useful utilities like `sponge`
brew install moreutils
# Brew Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# Brew Install GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed --default-names
# Brew Install Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew install bash
brew install bash-completion

# Brew Install wget with IRI support
brew install wget --enable-iri

# Brew Install RingoJS and Narwhal
# Note that the order in which these are installed is important; see http://git.io/brew-narwhal-ringo.
brew install ringojs
brew install narwhal

# Brew Install emacs
brew install emacs --HEAD --use-git-head --cocoa --srgb

# Brew Install more recent versions of some OS X tools
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/screen
brew install homebrew/php/php55 --with-gmp

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install xpdf
brew install xz

# Install other useful binaries.
brew install ack
#brew install exiv2
brew install git
brew install imagemagick --with-webp
brew install lua
#brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rhino
brew install speedtest_cli
brew install tree
brew install webkit2png
brew install zopfli

# use nvm to manage node
# brew install node # This installs `npm` too using the recommended installation method

brew install ghc
brew install ruby

brew install ssh-copy-id
brew install python --with-brewed-openssl
brew install python3 --with-brewed-openssl

brew install ansible
brew install unrar

# Brew Install  gotube dependencies
brew install cmake
brew install mariadb
brew install sphinx --id64 --mysql
# Brew Install go from the source
#brew install go
brew install mercurial

brew tap homebrew/binary
brew install packer

brew install aspell

# preview-latex dependency
brew install ghostscript

brew install pandoc

brew install gibo

brew install lxsplit

#brew tap Tox/tox
#brew install --HEAD libtoxcore

# Remove outdated versions from the cellar
brew cleanup
