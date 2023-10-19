#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

packages=(
    --set $NAME

    icon=$PACKAGES_NORMAL
    icon.color=$MAIN_COLOR

    label.drawing=on
    label=?
    label.color=$MAIN_COLOR
)

sketchybar "${packages[@]}"

BREW_UPDATE_COUNT=$(brew outdated | wc -l | tr -d ' ')
# NPM_COUNT=$(sudo -u pickle ncu --global --removeRange --format lines | wc -l | tr -d ' ')
# COUNT=$(($BREW_COUNT + $NPM_COUNT))
PACKAGE_UPDATE_COUNT=$BREW_UPDATE_COUNT

PACKAGES_COLOR=$MAIN_COLOR
PACKAGES_ICON=$PACKAGES_NORMAL

LABEL_DRAWING=on

case "$PACKAGE_UPDATE_COUNT" in
    [1-9][0-9]) PACKAGES_COLOR=$RED
      PACKAGES_ICON=$PACKAGES_UPDATES
      ;;
    [1-9]) PACKAGES_COLOR=$ORANGE
      PACKAGES_ICON=$PACKAGES_UPDATES
      ;;
    0) PACKAGES_COLOR=$GREEN
      LABEL_DRAWING=off
      ;;
esac

packages=(
    --set $NAME

    icon=$PACKAGES_ICON
    icon.color=$PACKAGES_COLOR

    label.drawing=$LABEL_DRAWING
    # label="$BREW_COUNT $NPM_COUNT"
    label=$PACKAGE_UPDATE_COUNT
    label.color=$PACKAGES_COLOR
)

sketchybar "${packages[@]}"
