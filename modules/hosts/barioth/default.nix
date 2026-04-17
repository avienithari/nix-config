{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../nixos/adb.nix
    ../../nixos/common-packages.nix
    ../../nixos/desktop-packages.nix
    ../../nixos/dev-packages.nix
    ../../nixos/fonts.nix
    ../../nixos/gnupg.nix
    ../../nixos/hyprland.nix
    ../../nixos/keyd.nix
    ../../nixos/maintenance.nix
    ../../nixos/mime.nix
    ../../nixos/ssh.nix
    ../../nixos/steam.nix
    ../../nixos/syncthing.nix
    ../../nixos/tailscale.nix
  ];

  networking = {
    hostName = lib.mkForce "barioth";
    nameservers = [ "192.168.0.252" ];
    networkmanager.appendNameservers = [ "192.168.0.252" ];
  };

  avien.ssh.passwordAuthentication = true;
}
