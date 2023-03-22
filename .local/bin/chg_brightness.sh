#!/bin/bash

MESSAGE="Brightness set to "
if [ "$1" == "up" ] ; then
    MESSAGE="Brightness increased to "
    SIGN="+"
    THRESHOLD=19.0
elif [ "$1" == "down" ] ; then 
    MESSAGE="Brightness decreased to "
    SIGN="-"
    THRESHOLD=21.0
fi

CURR_LEVEL=`light`
if (( $(echo "$CURR_LEVEL < $THRESHOLD" | bc -l)  )); then
  STEP=5.0
else
  STEP=10.0
fi

NEW_LEVEL=`echo "$CURR_LEVEL $SIGN $STEP" | bc`
if (( $(echo "$NEW_LEVEL < 5.0" | bc -l) )); then
  NEW_LEVEL=5.0
fi

if (( $(echo "$NEW_LEVEL > 100.0" | bc -l) )); then
  NEW_LEVEL=100.0
fi

notify-send "$MESSAGE" -u low -h int:value:$NEW_LEVEL -h string:synchronous:brightness

light -S $NEW_LEVEL

