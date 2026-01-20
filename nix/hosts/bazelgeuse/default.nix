{ config, lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../modules/adb.nix
    ../../modules/avien.nix
    ../../modules/bloat.nix
    ../../modules/bluetooth.nix
    ../../modules/common-packages.nix
    ../../modules/desktop-packages.nix
    ../../modules/dev-packages.nix
    ../../modules/fonts.nix
    ../../modules/gnupg.nix
    ../../modules/hyprland.nix
    ../../modules/keyd.nix
    ../../modules/maintenance.nix
    ../../modules/mime.nix
    ../../modules/mullvad.nix
    ../../modules/radeon.nix
    ../../modules/ssh.nix
    ../../modules/steam.nix
    ../../modules/syncthing.nix
    ../../modules/tailscale.nix
  ];

  networking = {
    hostName = lib.mkForce "bazelgeuse";
    nameservers = [ "192.168.0.252" ];
    networkmanager.appendNameservers = [ "192.168.0.252" ];
  };
}
