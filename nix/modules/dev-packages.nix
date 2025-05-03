{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    argparse
    cmake
    clisp
    jq
    lazygit
    lua
    luajit
    luajitPackages.jsregexp
    luarocks
    ninja
    php
  ];
}
