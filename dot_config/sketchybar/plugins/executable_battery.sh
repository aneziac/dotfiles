#!/bin/sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

# Nerd Font glyphs generated via printf (octal UTF-8) so the source stays ASCII.
case "${PERCENTAGE}" in
  9[0-9]|100) ICON=$(printf '\357\211\200') ;;  # nf-fa-battery_full      U+F240
  [6-8][0-9]) ICON=$(printf '\357\211\201') ;;  # nf-fa-battery_3_quarter U+F241
  [3-5][0-9]) ICON=$(printf '\357\211\202') ;;  # nf-fa-battery_half      U+F242
  [1-2][0-9]) ICON=$(printf '\357\211\203') ;;  # nf-fa-battery_quarter   U+F243
  *)          ICON=$(printf '\357\211\204') ;;  # nf-fa-battery_empty     U+F244
esac

# Color the icon by charge level (Gruvbox bright green/yellow/red).
COLOR=0xffb8bb26
case "${PERCENTAGE}" in
  [1-2][0-9]) COLOR=0xfffabd2f ;;
  [0-9]|0[0-9]) COLOR=0xfffb4934 ;;
esac

if [ "$CHARGING" != "" ]; then
  ICON=$(printf '\357\203\247')                 # nf-fa-bolt              U+F0E7
  COLOR=0xfffabd2f
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%"
