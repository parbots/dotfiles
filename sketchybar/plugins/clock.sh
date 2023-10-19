#!/bin/bash

clock=(
    --set $NAME

    label="$(date +'%a %d %h %I:%M %p')"
)

sketchybar "${clock[@]}"

