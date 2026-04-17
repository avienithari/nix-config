{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../services
    ../../nixos/adb.nix
    ../../nixos/bluetooth.nix
    ../../nixos/common-packages.nix
    ../../nixos/desktop-packages.nix
    ../../nixos/dev-packages.nix
    ../../nixos/fonts.nix
    ../../nixos/gnupg.nix
    ../../nixos/hyprland.nix
    ../../nixos/locale.nix
    ../../nixos/maintenance.nix
    ../../nixos/mime.nix
    ../../nixos/steam.nix
  ];

  networking = {
    hostName = lib.mkForce "magnamalo";
    nameservers = [ "192.168.0.252" ];
    networkmanager.appendNameservers = [ "192.168.0.252" ];
  };
}
