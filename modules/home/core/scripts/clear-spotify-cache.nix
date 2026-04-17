{ pkgs, ... }:

pkgs.writeShellScriptBin "clear-spotify-cache" ''
  #! /bin/sh

  rm -rf /home/avien/.cache/spotify/Data/*
''
