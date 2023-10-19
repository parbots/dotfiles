#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

SPACE_COLOR=$MAIN_COLOR

if ($SELECTED) then
    SPACE_COLOR=$HIGHLIGHT_COLOR
fi

space=(
    --set $NAME

    icon.color=$SPACE_COLOR
)

sketchybar "${space[@]}"
