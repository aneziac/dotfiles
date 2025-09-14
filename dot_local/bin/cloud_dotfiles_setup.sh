#!/bin/bash
set -euxo pipefail

HOME=/home/ubuntu

mkdir -p "$HOME/code"
cd "$HOME/code"

if [[ ! -d "dotfiles/.git" ]]; then
  git clone --depth=1 git@github.com:aneziac/dotfiles.git
else
  echo "dotfiles already cloned"
fi

cd dotfiles
chmod +x chsh.sh direct_install.sh install_packages.sh setup_symlinks.sh
./install_packages.sh
./setup_symlinks.sh
./chsh.sh
./direct_install.sh

