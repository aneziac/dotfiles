#!/usr/bin/env bash

TARGET_DIR="$HOME/code/qmk_firmware/keyboards/lily58/keymaps/nate"

if [ ! -d "$HOME/code/qmk_firmware" ]; then
    echo "Error: QMK firmware directory not found at $HOME/code/qmk_firmware"
    exit 1
fi

mkdir -p "$TARGET_DIR"

for file in ./lily58/*; do
    filename=$(basename "$file")
    ln -sf "$(realpath "$file")" "$TARGET_DIR/$filename"
    echo "Linked $filename"
done
