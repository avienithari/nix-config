{ pkgs, ... }:

let
  theme = "${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo";
  bell = "${theme}/bell.oga";
  alarm = "${theme}/alarm-clock-elapsed.oga";

  play = "${pkgs.sox}/bin/play";
  termdown = "${pkgs.termdown}/bin/termdown";
in
pkgs.writeShellScriptBin "chrono" ''
  MODE=$1

  case "$MODE" in
    stopwatch)
      ${termdown} --no-art
      ;;
    timer)
      shift
      ${termdown} --no-art "$@" && \
        ${play} -q ${bell} > /dev/null 2>&1
      ;;
    alarm)
      shift
      ${termdown} --no-art "$@" && \
        ${play} -q ${alarm} trim 0 3 > /dev/null 2>&1
      ;;
    *)
      echo "Usage: chrono [stopwatch | timer <time> | alarm <time>]"
      exit 1
      ;;
  esac
''
