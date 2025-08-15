#!/usr/bin/zsh
# Minimal 3-monitor launcher for Polybar

# Kill existing bars
pkill -x polybar 2>/dev/null

# Small wait so xrandr layout settles
sleep 0.3

# Launch one bar per output; tray only on primary (HDMI-1-0)
MONITORS=("DP-1" "HDMI-1-0" "eDP-1")

for M in "${MONITORS[@]}"; do
  if [ "$M" = "HDMI-1-0" ]; then
    TRAY_POS="right"
  else
    TRAY_POS="none"
  fi
  MONITOR="$M" TRAY_POS="$TRAY_POS" polybar mybar &
done

