{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fzf
    gcc
    go
    lua5_1
    neovim
    nixd
    nodejs_24
    python314
    ripgrep
    rustup
    tree-sitter
    unzip
    zig
  ];
}
