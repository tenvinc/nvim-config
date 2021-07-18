#!/bin/bash

PWD = $(pwd)
# Remove existing neovim
apt-get remove neovim
# Build newest neovim from source
git clone https://github.com/neovim/neovim
cd $PWD/neovim/ && rm -r build/ && make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim" && make install
echo 'export PATH="$HOME/neovim/bin:$PATH"' >> $HOME/.bashrc

# Setup CCLS language server
git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cd $PWD/ccls
# Setup clang
wget -c http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
tar xf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz

# Download "Pre-Built Binaries" from https://releases.llvm.org/download.html
# and unpack to /path/to/clang+llvm-xxx.
# Do not unpack to a temporary directory, as the clang resource directory is hard-coded
# into ccls at compile time!
# See https://github.com/MaskRay/ccls/wiki/FAQ#verify-the-clang-resource-directory-is-correct
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04 
cmake --build Release
cd Release && make install 

# Download and install rg (a faster version for grep)
cd $PWD 
wget https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
mkdir linux_rg && tar xfz ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz -C linux_rg --strip-components 1
mkdir ~/bin/ && mv linux_rg ~/bin/

# Transfer all the configurations
mkdir -p ~/.config
cp config ~/.config/nvim 
