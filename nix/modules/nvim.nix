{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fzf
    gcc
    go
    neovim
    nixd
    nodejs_23
    python314
    ripgrep
    rustup
    unzip
    zig
  ];
}
