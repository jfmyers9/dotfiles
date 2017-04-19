#!/bin/bash

# use Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# start ssh-agent
eval $(ssh-agent)

# hide mouse cursour when inactive
unclutter -root -visible &

# start pulse audio
start-pulseaudio-x11

exec /usr/bin/i3
