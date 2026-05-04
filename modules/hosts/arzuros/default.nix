{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../services
    ../../nixos
  ];

  host = {
    isGuiHost = true;
    gpu = "nvidia";
    desktop = "hyprland";
  };

  networking.hostName = lib.mkForce "arzuros";
}
