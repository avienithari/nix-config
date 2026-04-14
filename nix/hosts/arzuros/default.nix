{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../modules/bluetooth.nix
    ../../modules/common-packages.nix
    ../../modules/desktop-packages.nix
    ../../modules/dev-packages.nix
    ../../modules/fonts.nix
    ../../modules/gnupg.nix
    ../../modules/hyprland.nix
    ../../modules/keyd.nix
    ../../modules/maintenance.nix
    ../../modules/nvidia.nix
    ../../modules/ssh.nix
    ../../modules/syncthing.nix
    ../../modules/tailscale.nix
  ];

  networking = {
    hostName = lib.mkForce "arzuros";
  };
}
