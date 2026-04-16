{ pkgs, ... }:

pkgs.writeShellScriptBin "ytd" ''
  #!/usr/bin/env bash

  mode="$1"
  shift

  common_args=(
    --output "~/Downloads/%(title)s.%(ext)s"
    --embed-metadata
    --embed-thumbnail
  )

  case "$mode" in
    audio)
      exec ${pkgs.yt-dlp}/bin/yt-dlp \
        --format "bestaudio" \
        -x \
        --audio-format flac \
        "''${common_args[@]}" \
        "$@"
      ;;
    video)
      exec ${pkgs.yt-dlp}/bin/yt-dlp \
        --format "bestvideo[ext=mp4][vcodec^=avc]+bestaudio[ext=m4a]/best[ext=mp4]/best" \
        --merge-output-format mp4 \
        --remux-video mp4 \
        "''${common_args[@]}" \
        "$@"
      ;;
    *)
      echo -e "Usage:\nytd audio <url>\nytd video <url>"
      exit 1
      ;;
  esac
''
