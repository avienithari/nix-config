{ pkgs, ... }:

let
  bell = "${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/bell.oga";
in
pkgs.writeShellScriptBin "chrono" ''
  MODE=$1

  case "$MODE" in
    stopwatch)
      ${pkgs.termdown}/bin/termdown --no-art
      ;;
    timer)
      shift
      ${pkgs.termdown}/bin/termdown --no-art "$@" && \
        ${pkgs.sox}/bin/play -q ${bell} > /dev/null 2>&1
      ;;
    *)
      echo "Usage: chrono [stopwatch | timer <time>]"
      exit 1
      ;;
  esac
''
