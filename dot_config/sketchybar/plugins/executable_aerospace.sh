#!/bin/bash

# Active workspace: bright orange pill with dark text.
# Inactive workspace: muted bg1 pill with soft foreground.
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME \
               background.drawing=on \
               background.color=0xfffe8019 \
               background.border_width=0 \
               icon.color=0xff282828
else
    sketchybar --set $NAME \
               background.drawing=on \
               background.color=0xff3c3836 \
               background.border_width=0 \
               icon.color=0xff928374
fi
