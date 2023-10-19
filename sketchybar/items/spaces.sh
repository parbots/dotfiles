#!/bin/bash

seperator=(
    --add item space_seperator_start left
    --set space_seperator_start

    padding_left=4
    padding_right=4
)

sketchybar "${seperator[@]}"
# Single display
# SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8")

# Multiple displays
# SPACE_ICONS=("1" "2" "3" "4" "dashboard" "5" "6" "7" "8")
SPACE_ICONS=("dashboard" "1" "2" "3" "4" "5" "6" "7" "8")

sid=0
for i in "${!SPACE_ICONS[@]}"
do
    sid=$(($i+1))

    # hide dashboard space
    if [[ ${SPACE_ICONS[i]} = "dashboard" ]];
    then
        continue
    fi

    space=(
        --add space space.$sid left
        --set space.$sid

        associated_space=$sid

        icon="${SPACE_ICONS[i]}"
        icon.padding_left=15
        icon.padding_right=15

        label.drawing=off

        background.color=$BACKGROUND_HIGHLIGHT_COLOR
        background.padding_left=-5
        background.padding_right=-5

        script="$PLUGIN_DIR/space.sh"
        click_script="yabai -m space --focus $sid"
    )

    sketchybar "${space[@]}"
done

seperator=(
    --add item space_seperator left
    --set space_seperator

    associated_display=active

    padding_left=5

    icon=
    icon.font="$FONT:24"
    icon.padding_left=15
    icon.padding_right=15

    label.drawing=off
)

sketchybar "${seperator[@]}"
