#!/usr/bin/env bash
# Configure the external monitor.
#   monitor-layout.sh          apply the last-used mode (default: scaled)
#   monitor-layout.sh scaled   render at 3840x2160 and downscale, so UI matches
#                              the laptop panel's physical size at Xft.dpi=192
#   monitor-layout.sh native   plain 1920x1080 (for games: they see a real 1080p screen)
#   monitor-layout.sh toggle   switch between the two
# Exits 2 if no external monitor is connected.
set -euo pipefail

STATE="${XDG_CACHE_HOME:-$HOME/.cache}/monitor-layout-mode"

# Output names differ between PRIME modes (e.g. HDMI-1-0 in on-demand,
# HDMI-0 in nvidia mode), so detect them.
EXT=$(xrandr | awk '/^HDMI[^ ]* connected/{print $1; exit}')
INT=$(xrandr | awk '/^eDP[^ ]* connected/{print $1; exit}')
[ -n "$EXT" ] || exit 2

current=$(cat "$STATE" 2>/dev/null || echo scaled)
mode=${1:-$current}
if [ "$mode" = toggle ]; then
  if [ "$current" = scaled ]; then mode=native; else mode=scaled; fi
fi
case "$mode" in scaled|native) ;; *) echo "usage: $0 [scaled|native|toggle]" >&2; exit 64 ;; esac

# Remember the requested mode for the next login / i3 restart.
mkdir -p "$(dirname "$STATE")"
echo "$mode" > "$STATE"

# Reverse PRIME (on-demand mode): NVIDIA ignores scale transforms on sink
# outputs (the monitor would show only a cropped corner), so force native.
if xrandr --listproviders | grep -q "Sink Output.*NVIDIA"; then
  mode=native
fi

if [ "$mode" = scaled ]; then
  xrandr --output "$EXT" --mode 1920x1080 --rate 60 --scale 2x2 --primary --pos 0x0 \
    --output "$INT" --auto --pos 3840x0
else
  xrandr --output "$EXT" --mode 1920x1080 --rate 60 --scale 1x1 --primary --pos 0x0 \
    --output "$INT" --auto --pos 1920x0
fi

sleep 1
feh --no-fehbg --bg-fill ~/wallpapers/forest.jpg ~/wallpapers/house.jpg
