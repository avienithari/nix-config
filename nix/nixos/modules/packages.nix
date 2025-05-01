{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi

    _1password-gui-beta
    brave
    btop
    fastfetch
    gh
    ghostty
    git
    neovim
    nixpkgs-fmt
    stow
    tldr
    tmux
    tree

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
