#!/usr/bin/env bash
set -euo pipefail

sleep 1

status=0
~/.config/i3/monitor-layout.sh || status=$?
if [ "$status" -eq 2 ]; then
  # No external monitor.
  # ~/.config/i3/3monitors.sh
  # sleep 1
  # feh --no-fehbg --bg-fill ~/wallpapers/house.jpg ~/wallpapers/forest.jpg ~/wallpapers/waterfall.png
  feh --no-fehbg --bg-fill ~/wallpapers/nord-shards.png
fi

~/.config/polybar/launch.sh
