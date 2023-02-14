#!/bin/bash

if [ "$1" == "mute" ] ; then
    pamixer -t
    if [ `pamixer --get-mute` == "true" ] ; then
        MUTE_STATUS="on"
    else
        MUTE_STATUS="off"
    fi
    notify-send "Mute volume turned $MUTE_STATUS" -u low -h string:synchronous:volumemute
    exit 0
fi

MESSAGE="Volume set to "
if [ "$1" == "up" ] ; then
    MESSAGE="Volume increased to "
    pamixer --increase 5 
elif [ "$1" == "down" ] ; then 
    MESSAGE="Volume decreased to "
    pamixer --decrease 5
fi

NEW_LEVEL=`pamixer --get-volume`

notify-send "$MESSAGE" -u low -h int:value:$NEW_LEVEL -h string:synchronous:volume

