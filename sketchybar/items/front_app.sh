#!/bin/bash

FRONT_APP_SCRIPT='sketchybar --set $NAME label="$INFO"'

front_app=(
    --add item front_app left
    --set front_app

    associated_display=active

    icon.drawing=off

    label.color=$HIGHLIGHT_COLOR

    script="$FRONT_APP_SCRIPT"

    --subscribe front_app front_app_switched
)

sketchybar "${front_app[@]}"
