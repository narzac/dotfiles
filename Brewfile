# Install command-line tools using Homebrew
# Usage: `brew bundle Brewfile`

# Make sure we’re using the latest Homebrew
update

# Upgrade any already-installed formulae
upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
install coreutils
# Install some other useful utilities like `sponge`
install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
install findutils
# Install GNU `sed`, overwriting the built-in `sed`
install gnu-sed --default-names
# Install Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
install bash
install bash-completion

# Install wget with IRI support
install wget --enable-iri

# Install RingoJS and Narwhal
# Note that the order in which these are installed is important; see http://git.io/brew-narwhal-ringo.
install ringojs
install narwhal

# Install emacs
install emacs --HEAD --use-git-head --cocoa --srgb

# Install more recent versions of some OS X tools
install vim --override-system-vi
install homebrew/dupes/grep
install homebrew/dupes/screen
install homebrew/php/php55 --with-gmp

# Install other useful binaries
install ack
install bfg
#install exiv2
install foremost
install git
install hashpump
install imagemagick --with-webp
install lynx
install nmap
# install node # This installs `npm` too using the recommended installation method
# use nvm to manage node
install p7zip
install pigz
install pv
install rename
install rhino
install sqlmap
install tree
install ucspi-tcp # `tcpserver` et al.
install webkit2png
#install xpdf # unmet dependency xQuartz
install zopfli
install ghc
install homebrew/versions/lua52
install ruby

install ssh-copy-id
install python --with-brewed-openssl
install python3 --with-brewed-openssl

install ansible
install unrar

# Install  gotube dependencies
install cmake
install mariadb
install sphinx --id64 --mysql
install go
install mercurial

tap homebrew/binary
#install packer

install aspell

# preview-latex dependency
install ghostscript

install pandoc

install gibo

install lxsplit

tap Tox/tox
install --HEAD libtoxcore

# Remove outdated versions from the cellar
cleanup
