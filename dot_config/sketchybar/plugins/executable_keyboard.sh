#!/bin/sh

# Current keyboard layout, e.g. "com.apple.keylayout.US" -> "US".
KBD=$(printf '\357\204\234')    # nf-fa-keyboard  U+F11C

SRC=$(defaults read com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID 2>/dev/null)
LAYOUT=${SRC##*.}
[ -z "$LAYOUT" ] && LAYOUT="?"

sketchybar --set "$NAME" icon="$KBD" icon.color=0xffd3869b label="$LAYOUT"
