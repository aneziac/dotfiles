#!/usr/bin/env bash
set -euo pipefail

# --- 0) tiny settle time so EDID shows up ---
sleep 1.2

# --- 1) Displays: apply & verify layout ---
~/.config/i3/monitors.sh

# --- 2) Wallpaper (safe to run multiple times) ---
if [ -x ~/.config/i3/set-wallpapers.sh ]; then
  ~/.config/i3/set-wallpapers.sh || true
fi

# --- 3) Polybar: launch after monitors are correct ---
~/.config/polybar/launch.sh

