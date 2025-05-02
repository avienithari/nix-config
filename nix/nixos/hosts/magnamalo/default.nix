{ config, lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../modules/adb.nix
    ../../modules/avien.nix
    ../../modules/common-packages.nix
    ../../modules/desktop-packages.nix
    ../../modules/dev-packages.nix
    ../../modules/gnupg.nix
    ../../modules/hyprland.nix
    ../../modules/keyd.nix
    ../../modules/maintenance.nix
    ../../modules/ssh.nix
    ../../modules/steam.nix
    ../../modules/syncthing.nix
    ../../modules/tailscale.nix
  ];

  networking.hostName = lib.mkForce "magnamalo";
}
