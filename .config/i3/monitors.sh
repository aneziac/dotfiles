#!/usr/bin/zsh
xrandr \
  --output DP-1     --mode 3840x2160 --rotate left   --pos 0x0 \
  --output HDMI-1-0 --mode 3840x2160 --rotate normal --pos 2160x840 --primary \
  --output eDP-1    --mode 2560x1440 --rotate normal --pos 6000x1200

