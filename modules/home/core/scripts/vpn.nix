{ pkgs, ... }:

let
  mullvad = "${pkgs.mullvad}/bin/mullvad";
  pkill = "${pkgs.procps}/bin/pkill";
  sleep = "${pkgs.coreutils}/bin/sleep";
in
pkgs.writeShellScriptBin "vpn" ''
  check_account() {
    local status
    status=$(${mullvad} account get 2>&1)

    if [[ "$status" == *"Not logged in"* ]]; then
      echo "Aborted: Not logged in"
      exit 1
    fi
  }

  set_vpn() {
    local cmd="$1"
    local max_tries=7

    local wanted_state
    if [ "$cmd" = "connect" ]; then
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

  check_account

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
