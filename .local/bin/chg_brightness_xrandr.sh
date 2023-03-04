#!/bin/bash

MESSAGE="Brightness set to "
if [ "$1" == "up" ] ; then
    MESSAGE="Brightness increased to "
    SIGN="+"
    THRESHOLD=0.19
elif [ "$1" == "down" ] ; then 
    MESSAGE="Brightness decreased to "
    SIGN="-"
    THRESHOLD=0.21
fi

CURR_LEVEL=`xrandr --verbose | grep -i brightness | cut -d ' ' -f2 | head -n1`
if (( $(echo "$CURR_LEVEL < $THRESHOLD" | bc -l)  )); then
  STEP=0.05
else
  STEP=0.10
fi

NEW_LEVEL=`echo "$CURR_LEVEL $SIGN $STEP" | bc`
if (( $(echo "$NEW_LEVEL < 0.05" | bc -l) )); then 
  NEW_LEVEL=0.05
fi

if (( $(echo "$NEW_LEVEL > 1.0" | bc -l) )); then 
  NEW_LEVEL=1.0
fi

NEW_LEVEL_PERCENT=`echo "$NEW_LEVEL * 100.0" | bc`
NEW_LEVEL_PERCENT=${NEW_LEVEL_PERCENT%.*}


notify-send "$MESSAGE" -u low -h int:value:$NEW_LEVEL_PERCENT -h string:synchronous:brightness

xrandr --output eDP-1 --brightness $NEW_LEVEL

