#!/usr/bin/zsh

# Kill any old bars and wait until they're fully gone
pkill -x polybar 2>/dev/null || true
for i in {1..50}; do
  pgrep -x polybar >/dev/null || break
  sleep 0.05
done

# Wait until monitors are stable and we have *active* ones
for i in {1..60}; do
  # xrandr --listactivemonitors prints lines like: " 0: +*HDMI-1-0 3840/600x2160/340+2160+840  HDMI-1-0"
  count=$(xrandr --listactivemonitors 2>/dev/null | awk 'NR>1{c++} END{print c+0}')
  [ "$count" -ge 1 ] && break
  sleep 0.1
done

PRIMARY=$(xrandr --query | awk '/ primary/{print $1; exit}')
# Get names of active monitors, in order
mapfile -t MONS < <(xrandr --listactivemonitors | awk 'NR>1{print $NF}')

# Launch one bar per active monitor
for M in "${MONS[@]}"; do
  if [ "$M" = "$PRIMARY" ]; then
    TRAY_POS="right"
    CENTER_MODULES="title date"
  else
    TRAY_POS="none"
    CENTER_MODULES="date"
  fi
  MONITOR="$M" TRAY_POS="$TRAY_POS" SHOW_TITLE="$SHOW_TITLE" polybar mybar &
done
