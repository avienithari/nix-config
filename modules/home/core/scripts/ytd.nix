{ pkgs, ... }:

let
  yt-dlp = "${pkgs.yt-dlp}/bin/yt-dlp";
in
pkgs.writeShellScriptBin "ytd" ''
  mode="$1"
  shift

  common_args=(
    --paths "$HOME/Downloads"
    --output "%(title)s.%(ext)s"
    --embed-metadata
    --embed-thumbnail
  )

  case "$mode" in
    audio)
      exec ${yt-dlp} \
        --format "bestaudio" \
        -x \
        --audio-format flac \
        "''${common_args[@]}" \
        "$@"
      ;;
    video)
      exec ${yt-dlp} \
        --format \
        "bestvideo[ext=mp4][vcodec^=avc]+bestaudio[ext=m4a]/best[ext=mp4]/best" \
        --merge-output-format mp4 \
        --remux-video mp4 \
        "''${common_args[@]}" \
        "$@"
      ;;
    *)
      echo -e "Usage:\nytd audio <url> [-P <path>]\nytd video <url> [-P <path>]"
      exit 1
      ;;
  esac
''
