#!/bin/bash

# This script helps to install my custom nvim configuration, with all the dependencies
# on a fresh linux ubuntu 16.04 install, tested using docker container

GREEN='\033[0;32m'
NC='\033[0m' # No Color

PWD=$(pwd)
# Upgrade default CMake 
apt-get update
apt-get install -y software-properties-common apt-transport-https wget
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DE19EB17684BA42D
apt-add-repository 'deb https://apt.kitware.com/ubuntu/ xenial main'
apt-get update
apt install -y --allow-unauthenticated kitware-archive-keyring
# Remove then reinstall cmake
apt remove -y --purge --auto-remove cmake
apt install -y cmake --upgrade
rm /etc/apt/trusted.gpg.d/kitware.gpg

# Upgrade g++
add-apt-repository -y ppa:ubuntu-toolchain-r/test
apt update
apt install g++-7 -y
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 \
                         --slave /usr/bin/g++ g++ /usr/bin/g++-7 
update-alternatives --config gcc
gcc --version
g++ --version

# Remove existing neovim
apt-get remove neovim
# Install build prerequisites
apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl git

# Build newest neovim from source
echo -e "${GREEN}Installing neovim....${NC}"
if ! command -v nvim &> /dev/null
then
    git clone https://github.com/neovim/neovim
    cd $PWD/neovim/ && rm -rf build/ && make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim" && make install
    echo 'export PATH="$HOME/neovim/bin:$PATH"' >> $HOME/.bashrc
else
    echo -e "${GREEN}Neovim already installed${NC}"
fi

echo -e "${GREEN}Installing ccls....${NC}"
if ! command -v ccls &> /dev/null
then
    # Setup CCLS language server
    git clone --depth=1 --recursive https://github.com/MaskRay/ccls
    cd $PWD/ccls
    # Setup clang
    wget -c http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz
    tar xf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz

    # Download "Pre-Built Binaries" from https://releases.llvm.org/download.html
    # and unpack to /path/to/clang+llvm-xxx.
    # Do not unpack to a temporary directory, as the clang resource directory is hard-coded
    # into ccls at compile time!
    # See https://github.com/MaskRay/ccls/wiki/FAQ#verify-the-clang-resource-directory-is-correct
    cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-16.04 -DCMAKE_INSTALL_PREFIX=$HOME/ccls
    cmake --build Release
    cd Release && make install 
    echo 'export PATH="$HOME/ccls/bin:$PATH"' >> $HOME/.bashrc
else
    echo -e "${GREEN}CCLS already installed${NC}"
fi

echo -e "${GREEN}Installing rg ....${NC}"
if [[ ! -d ~/bin/linux_rg ]]
then
   # Download and install rg (a faster version for grep)
   cd $PWD 
   wget https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
   mkdir -p linux_rg && tar xfz ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz -C linux_rg --strip-components 1
   mkdir -p ~/bin/ && mv linux_rg ~/bin/
else
    echo -e "${GREEN}RG already installed${NC}"
fi

# Transfer all the configurations
cd $PWD
mkdir -p ~/.config
cp -r $PWD/config ~/.config/nvim 

# Install node needed for coc
curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt install -y nodejs
