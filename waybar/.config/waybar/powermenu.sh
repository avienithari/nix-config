#!/usr/bin/env bash

config="$HOME/.config/rofi/powermenu.rasi"

actions=$(echo -e "  Lock\n  Shutdown\n  Reboot\n  Suspend\n  Hibernate\n󰞘  Logout")

selected_option=$(echo -e "$actions" | rofi -dmenu -i -config "${config}" || pkill -x rofi)

case "$selected_option" in
*Lock)
  loginctl lock-session
  ;;
*Shutdown)
  systemctl poweroff
  ;;
*Reboot)
  systemctl reboot
  ;;
*Suspend)
  systemctl suspend
  ;;
*Hibernate)
  systemctl hibernate
  ;;
*Logout)
  loginctl kill-session "$XDG_SESSION_ID"
  ;;
esac
