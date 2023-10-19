#!/bin/bash

source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/colors.sh"

BATTERY_INFO="$(pmset -g batt)"
BATTERY_PERCENTAGE=$(echo $BATTERY_INFO | grep -Eo "\d+%" | cut -d% -f1)
BATTERY_IS_CHARGING=$(echo $BATTERY_INFO | grep 'AC Power')
BATTERY_LABEL_ICON=

if [ $BATTERY_PERCENTAGE = "" ]; then
  exit 0
fi

case ${BATTERY_PERCENTAGE} in
  [9-9][0-9]|100) BATTERY_ICON=$BATTERY_100
    BATTERY_COLOR=$GREEN
  ;;
  [7-9][0-9]) BATTERY_ICON=$BATTERY_75
    BATTERY_COLOR=$BLUE
  ;;
  [5-6][0-9]) BATTERY_ICON=$BATTERY_50
    BATTERY_COLOR=$YELLOW
  ;;
  [3-4][0-9]) BATTERY_ICON=$BATTERY_25
    BATTERY_COLOR=$ORANGE
  ;;
  [1-2][0-9]) BATTERY_ICON=$BATTERY_25
    BATTERY_COLOR=$RED
  ;;
  *) BATTERY_ICON=$BATTERY_0
    BATTERY_COLOR=$RED
  ;;
esac

if [[ $BATTERY_IS_CHARGING != "" ]]; then
 BATTERY_ICON=$BATTERY_CHARGING
 BATTERY_LABEL_ICON=
fi

battery=(
    --set $NAME

    icon=$BATTERY_ICON
    icon.color=$BATTERY_COLOR

    label="${BATTERY_LABEL_ICON}${BATTERY_PERCENTAGE}%"
    label.color=$BATTERY_COLOR
)

sketchybar "${battery[@]}"
