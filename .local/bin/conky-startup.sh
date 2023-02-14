killall conky
if [ "$1" == "i3" ] ; then
    sleep 3s && conky -c "$HOME/.config/conky/i3.conkyrc" &
else
    sleep 3s && conky -c "$HOME/.config/conky/openbox.conkyrc" &
fi
