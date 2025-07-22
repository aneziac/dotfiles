#!/bin/bash

set -euo pipefail

PKG_FILE="packages.txt"

# Detect OS
if [[ "$(uname)" == "Darwin" ]]; then
    OS="macos"
elif [[ -f /etc/os-release ]]; then
    . /etc/os-release
    if [[ "$ID" == "ubuntu" || "$ID_LIKE" == *debian* ]]; then
        OS="debian"
    elif [[ "$ID" == "arch" ]]; then
        OS="arch"
    else
        echo "Unsupported Linux distro: $ID"
        exit 1
    fi
else
    echo "Unsupported OS"
    exit 1
fi

# Install packages
while read -r pkg; do
    [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue  # Skip blank lines and comments

    echo "Installing: $pkg"

    case "$OS" in
        macos)
            brew install "$pkg" || echo "Failed to install $pkg"
            ;;
        debian)
            sudo apt-get install -y "$pkg" || echo "Failed to install $pkg"
            ;;
        arch)
            sudo pacman -S --noconfirm "$pkg" || echo "Failed to install $pkg"
            ;;
    esac
done < "$PKG_FILE"


