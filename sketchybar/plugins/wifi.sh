#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

WIFI=$(networksetup -getairportnetwork en0 | awk -F": " '{print $2}')
WIFI_INFO=${WIFI:-"Not Connected"}
WIFI_ICON=$WIFI_CONNECTED
WIFI_COLOR=$GREEN

# If wifi isn't connected
if [ -z "$WIFI" ]; then
    WIFI_ICON=$WIFI_NONE
    WIFI_COLOR=$RED
fi

wifi=(
    --set $NAME

    icon=$WIFI_ICON
    icon.color=$WIFI_COLOR

    label="${WIFI_INFO}"
    label.color=$WIFI_COLOR
)

sketchybar "${wifi[@]}"
