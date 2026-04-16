#!/usr/bin/env bash

BLACK='#26233a'
DEFAULT='#ebbcba'
RED='#eb6f92'
GOLD='#f6c177'

i3lock \
--insidever-color=$BLACK     \
--ringver-color=$RED \
\
--insidewrong-color=$BLACK   \
--ringwrong-color=$RED     \
\
--inside-color=$BLACK        \
--ring-color=$DEFAULT        \
--line-color=$BLACK          \
--separator-color=$DEFAULT   \
\
--verif-color=$GOLD          \
--wrong-color=$GOLD          \
--time-color=$GOLD           \
--date-color=$GOLD           \
--layout-color=$GOLD         \
--keyhl-color=$RED         \
--bshl-color=$RED          \
\
--screen 1                   \
--blur 9                     \
--clock                      \
--indicator                  \
--time-str="%H:%M"        \
--date-str="%Y-%m-%d"       \
