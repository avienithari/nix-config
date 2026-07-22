{ pkgs, ... }:

pkgs.writeShellScriptBin "remote" ''
  case "$1" in
    up)
      systemctl --user start sunshine
      ;;
    down)
      systemctl --user stop sunshine
      ;;
    *)
      echo "Usage: remote [up | down]"
      exit 1
      ;;
  esac
''
