#!/bin/bash

wifi=(
    --add item wifi right
    --set wifi

    icon.font="$FONT:24"
    icon.padding_left=10

    label.padding_left=10
    label.padding_right=5

    background.color=$BACKGROUND_HIGHLIGHT_COLOR
    background.padding_right=-5

    updates=on
    update_freq=1200

    script="$PLUGIN_DIR/wifi.sh"

    --subscribe wifi wifi_change
)

sketchybar "${wifi[@]}"
