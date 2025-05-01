{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    btop
    fastfetch
    fd
    gh
    ghostty
    git
    neovim
    nixpkgs-fmt
    speedtest-cli
    stow
    tldr
    tmux
    tokei
    tree
    wget

    fzf
    gcc
    go
    nodejs_23
    python314
    rustup
    unzip
    zig
  ];
}
