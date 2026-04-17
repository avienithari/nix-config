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

    feature = {
      bloat = true;
      steam = true;
    };
  };

  networking = {
    hostName = lib.mkForce "zinogre";
    nameservers = [ "192.168.0.252" ];
    networkmanager.appendNameservers = [ "192.168.0.252" ];
  };
}
