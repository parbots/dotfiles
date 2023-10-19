#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

VOLUME_LEVEL=$(osascript -e 'output volume of (get volume settings)')
case $VOLUME_LEVEL in
  [1-9]|[1-9][0-9]|100) VOLUME_ICON=$VOLUME_ON
    VOLUME_COLOR=$BLUE
    ;;
  *) VOLUME_ICON=$VOLUME_OFF
    VOLUME_COLOR=$RED
    ;;
esac

volume=(
    --set $NAME

    icon=$VOLUME_ICON
    icon.color=$VOLUME_COLOR

    label="$VOLUME_LEVEL%"
    label.color=$VOLUME_COLOR
)

sketchybar "${volume[@]}"
