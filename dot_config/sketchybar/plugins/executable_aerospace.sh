#!/bin/bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME \
               background.drawing=on \
               background.color=0xffd65d0e \
               icon.color=0xff282828
else
    sketchybar --set $NAME \
               background.drawing=on \
               background.color=0xff3c3836 \
               icon.color=0xffebdbb2
fi
