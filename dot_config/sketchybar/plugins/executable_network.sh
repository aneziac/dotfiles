#!/bin/sh

# Nerd Font glyphs (octal UTF-8 so the source stays ASCII).
WIFI=$(printf '\357\207\253')     # nf-fa-wifi    U+F1EB
GLOBE=$(printf '\357\202\254')    # nf-fa-globe   U+F0AC

WIFI_IF=en0
ETH_IF=en1

WIFI_IP=$(ipconfig getifaddr "$WIFI_IF" 2>/dev/null)
ETH_IP=$(ipconfig getifaddr "$ETH_IF" 2>/dev/null)

if [ -n "$WIFI_IP" ]; then
  # Connected over Wi-Fi. SSID may be withheld by macOS (needs Location), so
  # fall back to a plain "Wi-Fi" label when it isn't available.
  SSID=$(networksetup -getairportnetwork "$WIFI_IF" 2>/dev/null | sed 's/^Current Wi-Fi Network: //')
  case "$SSID" in
    *"not associated"*|*"not currently"*|"") LABEL="Wi-Fi" ;;
    *) LABEL="$SSID" ;;
  esac
  sketchybar --set "$NAME" icon="$WIFI" icon.color=0xff83a598 label="$LABEL"
elif [ -n "$ETH_IP" ]; then
  sketchybar --set "$NAME" icon="$GLOBE" icon.color=0xffb8bb26 label="Ethernet"
else
  # Offline: dim the Wi-Fi icon.
  sketchybar --set "$NAME" icon="$WIFI" icon.color=0xff928374 label="Off"
fi
