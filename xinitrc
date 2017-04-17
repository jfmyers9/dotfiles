#!/bin/bash
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
eval $(ssh-agent)
exec i3
