#!/bin/bash

if [ "$1" == "mute" ] ; then
    pactl set-sink-mute 0 toggle
    MUTE_STATUS=`pactl get-sink-mute 0 | grep Mute | cut -d: -f2 | xargs`
    if [ ${MUTE_STATUS:0:1} == "n" ] ; then
        MUTE_STATUS="off"
    else
        MUTE_STATUS="on"
    fi
    notify-send "Mute volume turned $MUTE_STATUS" -u low -h string:synchronous:volumemute
    exit 0
fi

MESSAGE="Volume set to "
if [ "$1" == "up" ] ; then
    MESSAGE="Volume increased to "
    CURR_LEVEL=`pactl get-sink-volume 0 | grep Volume | cut -d/ -f2 | cut -d% -f1 | xargs`
    if (( $(echo "$CURR_LEVEL < 116" | bc -l) )); then 
        pactl set-sink-volume 0 +5% 
    fi
elif [ "$1" == "down" ] ; then 
    MESSAGE="Volume decreased to "
    pactl set-sink-volume 0 -5%
fi

NEW_LEVEL=`pactl get-sink-volume 0 | grep Volume | cut -d/ -f2 | cut -d% -f1 | xargs`

notify-send "$MESSAGE" -u low -h int:value:$NEW_LEVEL -h string:synchronous:volume

