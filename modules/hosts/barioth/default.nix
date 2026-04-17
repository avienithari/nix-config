{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../services
    ../../nixos
    ../../nixos/desktop-packages.nix
    ../../nixos/fonts.nix
    ../../nixos/hyprland.nix
    ../../nixos/mime.nix
    ../../nixos/steam.nix
  ];

  networking = {
    hostName = lib.mkForce "barioth";
    nameservers = [ "192.168.0.252" ];
    networkmanager.appendNameservers = [ "192.168.0.252" ];
  };

  avien.ssh.passwordAuthentication = true;
}
