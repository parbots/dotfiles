#!/bin/bash

volume=(
    --add item volume right
    --set volume

    icon.font="$FONT:24"
    icon.padding_left=20

    label.padding_left=10
    label.padding_right=5

    background.color=$BACKGROUND_HIGHLIGHT_COLOR
    background.padding_left=-5
    background.padding_right=-5

    updates=on
    update_freq=1200

    script="$PLUGIN_DIR/volume.sh"

    --subscribe volume volume_change
)

sketchybar "${volume[@]}"
