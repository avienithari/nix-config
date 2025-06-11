{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    argparse
    cmake
    clisp
    jq
    lua
    luajit
    luajitPackages.jsregexp
    luarocks
    ninja
    php
  ];
}
