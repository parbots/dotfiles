#!/bin/bash

battery=(
    --add item battery right
    --set battery

    icon.font="$FONT:24"
    icon.padding_left=20

    label.padding_left=10
    label.padding_right=10

    background.color=$BACKGROUND_HIGHLIGHT_COLOR
    background.padding_left=-5

    updates=on
    update_freq=60

    script="$PLUGIN_DIR/battery.sh"

    --subscribe battery power_source_change system_woke
)

sketchybar "${battery[@]}"
