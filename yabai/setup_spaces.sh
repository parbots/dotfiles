#!/bin/bash

# Total number of desired spaces
DESIRED_SPACES=8
echo "Desired Spaces: $DESIRED_SPACES"

# Get number of current displays
DISPLAYS=$(yabai -m query --displays | jq length)
echo "Displays: $DISPLAYS"

# Total spaces per display
DESIRED_SPACES_PER_DISPLAY=$(( $DESIRED_SPACES / $DISPLAYS ))
echo "Desired Spaces per Display: $DESIRED_SPACES_PER_DISPLAY"

DELTA=0

# Loop through each display
# Check missing spaces on display
# Then loop through each missing space on the display
for DISPLAY in $(seq 1 $DISPLAYS);
do
    # Get current spaces on display
    EXISTING_SPACES=$(yabai -m query --displays --display $DISPLAY | jq '.spaces | length')

    # Get index of next space
    SPACE_IDX=$(( $EXISTING_SPACES + $DELTA + 1))

    # If first display, remove dashboard space
    if [[ $DISPLAY -eq 1 ]];
    then
        EXISTING_SPACES=$(( $EXISTING_SPACES - 1 ))
    fi

    MISSING_SPACES=$(( $DESIRED_SPACES_PER_DISPLAY - $EXISTING_SPACES ))

    echo ""
    echo "Display: $DISPLAY"
    echo "  Current Spaces: $EXISTING_SPACES"
    echo "  Missing Spaces: $MISSING_SPACES"
    echo ""

    if [[ $MISSING_SPACES -gt 0 ]];
    then
        for i in $(seq 1 $MISSING_SPACES);
        do
            echo "Creating space $SPACE_IDX on display $DISPLAY"
            yabai -m space --create $DISPLAY

            echo "Sending space $SPACE_IDX to display $DISPLAY"
            yabai -m space $SPACE_IDX --display $DISPLAY

            SPACE_IDX=$(( $SPACE_IDX + 1 ))
        done
    elif [[ $MISSING_SPACES -lt 0 ]];
    then
        SPACE_IDX=$(( $SPACE_IDX - 1 ))

        for i in $(seq 1 $(( -$MISSING_SPACES )));
        do
            echo "Destroying space $SPACE_IDX on display $DISPLAY"
            yabai -m space --destroy $SPACE_IDX
            SPACE_IDX=$(( $SPACE_IDX - 1 ))
        done
    fi

    DELTA=$(( $DELTA + $EXISTING_SPACES ))

    if [[ $DISPLAY -eq 1 ]];
    then
        DELTA=$(( $EXISTING_SPACES - 1 ))
    fi

done
