{ config, lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../modules/adb.nix
    ../../modules/avien.nix
    ../../modules/bluetooth.nix
    ../../modules/common-packages.nix
    ../../modules/desktop-packages.nix
    ../../modules/dev-packages.nix
    ../../modules/fonts.nix
    ../../modules/gnome.nix
    ../../modules/nvidia.nix
    ../../modules/gnupg.nix
    ../../modules/maintenance.nix
    ../../modules/ssh.nix
    ../../modules/steam.nix
    ../../modules/syncthing.nix
  ];

  networking = {
    hostName = lib.mkForce "zinogre";
    nameservers = [ "192.168.0.252" ];
    networkmanager.appendNameservers = [ "192.168.0.252" ];
  };

  avien.ssh.passwordAuthentication = true;
}
