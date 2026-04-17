{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../services
    ../../nixos
    ../../nixos/steam.nix
  ];

  host = {
    isGuiHost = true;
    desktop = "hyprland";
  };

  networking = {
    hostName = lib.mkForce "magnamalo";
    nameservers = [ "192.168.0.252" ];
    networkmanager.appendNameservers = [ "192.168.0.252" ];
  };
}
