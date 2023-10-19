#!/bin/bash

clock=(
    --add item clock right
    --set clock

    padding_right=20
    padding_left=15

    icon=$CLOCK
    icon.font="$FONT:24"

    label.padding_left=10

    updates=on
    update_freq=10

    script="$PLUGIN_DIR/clock.sh"
)

sketchybar "${clock[@]}"
