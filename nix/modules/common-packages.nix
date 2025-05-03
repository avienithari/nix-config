{ config, pkgs, ... }:

{
  imports = [ ./nvim.nix ];

  environment.systemPackages = with pkgs; [
    bat
    btop
    fastfetch
    fd
    gh
    ghostty
    git
    nixpkgs-fmt
    speedtest-cli
    stow
    tldr
    tmux
    tokei
    tree
    wget
  ];
}
