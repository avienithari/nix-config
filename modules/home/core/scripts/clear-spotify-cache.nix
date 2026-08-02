{ pkgs, ... }:

pkgs.writeShellScriptBin "clear-spotify-cache" ''
  rm -rf /home/avien/.cache/spotify/Data/*
''
