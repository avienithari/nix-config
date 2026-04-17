{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../nixos/adb.nix
    ../../nixos/bluetooth.nix
    ../../nixos/common-packages.nix
    ../../nixos/desktop-packages.nix
    ../../nixos/dev-packages.nix
    ../../nixos/fonts.nix
    ../../nixos/gnupg.nix
    ../../nixos/hyprland.nix
    ../../nixos/keyd.nix
    ../../nixos/locale.nix
    ../../nixos/maintenance.nix
    ../../nixos/mime.nix
    ../../nixos/mullvad.nix
    ../../nixos/ssh.nix
    ../../nixos/steam.nix
    ../../nixos/syncthing.nix
    ../../nixos/tailscale.nix
  ];

  networking = {
    hostName = lib.mkForce "magnamalo";
    nameservers = [ "192.168.0.252" ];
    networkmanager.appendNameservers = [ "192.168.0.252" ];
  };
}
