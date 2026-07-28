{ pkgs, ... }:

let
  pkill = "${pkgs.procps}/bin/pkill";
in
pkgs.writeShellScriptBin "remote" ''
  case "$1" in
    up)
      systemctl --user start sunshine
      ${pkill} -RTMIN+8 waybar
      ;;
    down)
      systemctl --user stop sunshine
      ${pkill} -RTMIN+8 waybar
      ;;
    *)
      echo "Usage: remote [up | down]"
      exit 1
      ;;
  esac
''
