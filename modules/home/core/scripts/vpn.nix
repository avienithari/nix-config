{ pkgs, ... }:

let
  awk = "${pkgs.gawk}/bin/awk";
  date = "${pkgs.coreutils}/bin/date";
  mullvad = "${pkgs.mullvad}/bin/mullvad";
  pkill = "${pkgs.procps}/bin/pkill";
  sleep = "${pkgs.coreutils}/bin/sleep";
in
pkgs.writeShellScriptBin "vpn" ''
  check_account() {
    local status
    status=$(${mullvad} account get 2>&1)

    if [[ "$status" == *"Not logged in"* ]]; then
      echo "Not logged in"
      return 1
    fi

    local expire_str expire_epoch current_epoch
    expire_str=$(${awk} '/Expires at/ {print $3, $4, $5}' <<< "$status")
    expire_epoch=$(${date} -d "$expire_str" +%s)
    current_epoch=$(${date} +%s)

    if [[ -n "$expire_epoch" ]] && \
      [[ "$current_epoch" -ge "$expire_epoch" ]]; then
      echo "No time left"
      return 1
    fi

    return 0
  }

  set_vpn() {
    local cmd="$1"
    local max_tries=7

    local wanted_state
    if [ "$cmd" = "connect" ]; then
      if ! reason=$(check_account); then
        echo "Aborted: $reason"
        exit 1
      fi

      wanted_state="Connected"

    elif [ "$cmd" = "disconnect" ]; then
      wanted_state="Disconnected"
    fi

    ${mullvad} "$cmd" >/dev/null 2>&1

    (
      local tries=0
      while [ "$tries" -lt "$max_tries" ]; do
        if [[ $(${mullvad} status) == *"$wanted_state"* ]]; then
          ${pkill} -RTMIN+9 waybar
          exit 0
        fi

        ${sleep} 1
        tries=$((tries + 1))
      done
    ) &>/dev/null &
  }

  case "$1" in
    up)
      set_vpn connect
      ;;
    down)
      set_vpn disconnect
      ;;
    *)
      echo "Usage: vpn [up | down]"
      exit 1
      ;;
  esac
''
