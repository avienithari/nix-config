{ config, lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../modules/adb.nix
    ../../modules/avien.nix
    ../../modules/common-packages.nix
    ../../modules/desktop-packages.nix
    ../../modules/dev-packages.nix
    ../../modules/fonts.nix
    ../../modules/gnupg.nix
    ../../modules/hyprland.nix
    ../../modules/keyd.nix
    ../../modules/maintenance.nix
    ../../modules/mime.nix
    ../../modules/ssh.nix
    ../../modules/syncthing.nix
    ../../modules/tailscale.nix
  ];

  networking = {
    hostName = lib.mkForce "barioth";
    nameservers = [ "192.168.0.252" ];
    networkmanager.appendNameservers = [ "192.168.0.252" ];
  };

  avien.ssh.passwordAuthentication = true;
}
