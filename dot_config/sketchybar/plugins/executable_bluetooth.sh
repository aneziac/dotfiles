#!/bin/sh

# ControllerPowerState is 1 when the Bluetooth radio is on, 0 when off (fast).
# When on, pull the connected device name(s) from system_profiler JSON — each
# connected entry is keyed by the device name. system_profiler is quick here
# (~0.2s), so it's fine at a low update frequency.
BT=$(printf '\357\212\223')     # nf-fa-bluetooth  U+F293

STATE=$(defaults read /Library/Preferences/com.apple.Bluetooth ControllerPowerState 2>/dev/null)

if [ "$STATE" != "1" ]; then
  sketchybar --set "$NAME" icon="$BT" icon.color=0xff928374 label.drawing=off
  exit 0
fi

DEVICE=$(system_profiler -json SPBluetoothDataType 2>/dev/null \
  | jq -r '[.SPBluetoothDataType[0].device_connected[]? | keys[0]] | join(", ")' 2>/dev/null)

if [ -n "$DEVICE" ] && [ "$DEVICE" != "null" ]; then
  sketchybar --set "$NAME" icon="$BT" icon.color=0xff83a598 label="$DEVICE" label.drawing=on
else
  # Radio on, nothing connected — icon only.
  sketchybar --set "$NAME" icon="$BT" icon.color=0xff83a598 label.drawing=off
fi
