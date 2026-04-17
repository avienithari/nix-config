{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../services
    ../../nixos/bluetooth.nix
    ../../nixos/common-packages.nix
    ../../nixos/desktop-packages.nix
    ../../nixos/dev-packages.nix
    ../../nixos/fonts.nix
    ../../nixos/gnupg.nix
    ../../nixos/hyprland.nix
    ../../nixos/maintenance.nix
    ../../nixos/nvidia.nix
  ];

  networking = {
    hostName = lib.mkForce "arzuros";
  };
}
