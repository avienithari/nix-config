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
    desktop = "gnome";

    feature.steam = true;
  };

  networking.hostName = lib.mkForce "zinogre";
}
