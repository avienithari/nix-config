{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../services
    ../../nixos
    ../../nixos/bloat.nix
    ../../nixos/steam.nix
  ];

  host = {
    isGuiHost = true;
    gpu = "nvidia";
    desktop = "gnome";
  };

  networking = {
    hostName = lib.mkForce "zinogre";
    nameservers = [ "192.168.0.252" ];
    networkmanager.appendNameservers = [ "192.168.0.252" ];
  };
}
