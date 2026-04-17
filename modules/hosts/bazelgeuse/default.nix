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
    gpu = "radeon";
    desktop = "hyprland";
  };

  networking = {
    hostName = lib.mkForce "bazelgeuse";
    nameservers = [ "192.168.0.252" ];
    networkmanager.appendNameservers = [ "192.168.0.252" ];
  };
}
