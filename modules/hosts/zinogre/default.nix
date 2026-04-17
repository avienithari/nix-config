{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../services
    ../../nixos
    ../../nixos/bloat.nix
    ../../nixos/desktop-packages.nix
    ../../nixos/fonts.nix
    ../../nixos/gnome.nix
    ../../nixos/nvidia.nix
    ../../nixos/steam.nix
  ];

  networking = {
    hostName = lib.mkForce "zinogre";
    nameservers = [ "192.168.0.252" ];
    networkmanager.appendNameservers = [ "192.168.0.252" ];
  };
}
