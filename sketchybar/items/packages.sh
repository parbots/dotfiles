#!/bin/bash

packages=(
    --add event update

    --add item packages right
    --set packages

    padding_right=5

    icon=$PACKAGES_NORMAL
    icon.font="$FONT:24"
    icon.color=$MAIN_COLOR
    icon.padding_left=15
    icon.padding_right=10

    label=?
    label.color=$MAIN_COLOR
    label.padding_right=10

    updates=on
    update_freq=1200

    script="$PLUGIN_DIR/packages.sh"

    --subscribe packages update
)

sketchybar "${packages[@]}"
