{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    argparse
    clisp
    cmake
    jq
    lua
    luajit
    luajitPackages.jsregexp
    luarocks
    ninja
    php
  ];
}
