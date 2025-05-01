{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnupg
    pinentry-curses

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
    syncthing
    tailscale
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

    keyd
    hyprland
    waybar
    wofi

    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
  ];
}
