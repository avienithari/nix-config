#!/usr/bin/env bash


if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar -c ~/.config/polybar/config.ini --reload avien &
    done
else
    polybar -c ~/.config/polybar/config.ini --reload avien &
fi
