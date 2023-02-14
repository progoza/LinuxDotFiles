#!/bin/bash

MESSAGE="Brightness set to "
if [ "$1" == "up" ] ; then
    MESSAGE="Brightness increased to "
    SIGN="+"
    THRESHOLD=19
elif [ "$1" == "down" ] ; then 
    MESSAGE="Brightness decreased to "
    SIGN="-"
    THRESHOLD=21
fi

CURR_LEVEL=`xbacklight -get`
if [ $CURR_LEVEL -lt $THRESHOLD ] ; then
  STEP=5
else
  STEP=10
fi

xbacklight ${SIGN}${STEP}

NEW_LEVEL=`xbacklight -get`

notify-send "$MESSAGE" -u low -h int:value:$NEW_LEVEL -h string:synchronous:brightness
