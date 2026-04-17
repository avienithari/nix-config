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
    gpu = "radeon";
    desktop = "hyprland";

    feature = {
      bloat = true;
      steam = true;
    };
  };

  networking = {
    hostName = lib.mkForce "bazelgeuse";
    nameservers = [ "192.168.0.252" ];
    networkmanager.appendNameservers = [ "192.168.0.252" ];
  };
}
