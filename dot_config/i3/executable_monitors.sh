#!/usr/bin/zsh
set -euo pipefail
exec > >(tee -a /tmp/monitors.log) 2>&1
set -x

LEFT="DP-1"        # vertical (left)
CENTER="HDMI-1-0"  # front (primary)
RIGHT="eDP-1"      # laptop (right)

# Give hotplug/EDID a moment (HDMI can be slow)
sleep 2

# Ensure we're in the right X session; bail if not
: "${DISPLAY:=:0}"
export DISPLAY

# Big enough virtual screen first (prevents half-black/panning)
xrandr --fb 8560x3840

# Apply exact modes/positions
xrandr \
  --output "$LEFT"   --mode 3840x2160 --rate 60 --rotate left   --pos 0x0 \
  --output "$CENTER" --mode 3840x2160 --rate 60 --rotate normal --pos 2160x840 --primary \
  --output "$RIGHT"  --mode 2560x1440 --rate 60 --rotate normal --pos 6000x1200

# Turn off anything unexpected
for out in $(xrandr | awk '/ connected/{print $1}'); do
  if [ "$out" != "$LEFT" ] && [ "$out" != "$CENTER" ] && [ "$out" != "$RIGHT" ]; then
    xrandr --output "$out" --off || true
  fi
done

# Show final state
xrandr --current

