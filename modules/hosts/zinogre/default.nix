{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../nixos/adb.nix
    ../../nixos/avien.nix
    ../../nixos/bloat.nix
    ../../nixos/bluetooth.nix
    ../../nixos/common-packages.nix
    ../../nixos/desktop-packages.nix
    ../../nixos/dev-packages.nix
    ../../nixos/fonts.nix
    ../../nixos/gnome.nix
    ../../nixos/gnupg.nix
    ../../nixos/maintenance.nix
    ../../nixos/nvidia.nix
    ../../nixos/ssh.nix
    ../../nixos/steam.nix
    ../../nixos/syncthing.nix
  ];

  networking = {
    hostName = lib.mkForce "zinogre";
    nameservers = [ "192.168.0.252" ];
    networkmanager.appendNameservers = [ "192.168.0.252" ];
  };
}
