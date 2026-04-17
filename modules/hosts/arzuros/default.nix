{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../services
    ../../nixos
    ../../nixos/desktop-packages.nix
    ../../nixos/fonts.nix
    ../../nixos/hyprland.nix
    ../../nixos/nvidia.nix
  ];

  networking = {
    hostName = lib.mkForce "arzuros";
  };
}
