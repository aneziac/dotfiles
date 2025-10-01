#!/usr/bin/env bash
set -euo pipefail

sleep 1

if [[ true ]] then
  xrandr --output HDMI-1-0 --mode 3840x2160 --rate 60 --primary --right-of eDP-1
  sleep 1
  feh --no-fehbg --bg-fill ~/wallpapers/forest.jpg ~/wallpapers/house.jpg
else
  ~/.config/i3/3monitors.sh
  sleep 1
  feh --no-fehbg --bg-fill ~/wallpapers/house.jpg ~/wallpapers/forest.jpg ~/wallpapers/waterfall.png
fi

~/.config/polybar/launch.sh

