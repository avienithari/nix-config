{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../nixos/bluetooth.nix
    ../../nixos/common-packages.nix
    ../../nixos/desktop-packages.nix
    ../../nixos/dev-packages.nix
    ../../nixos/fonts.nix
    ../../nixos/gnupg.nix
    ../../nixos/hyprland.nix
    ../../nixos/keyd.nix
    ../../nixos/maintenance.nix
    ../../nixos/nvidia.nix
    ../../nixos/ssh.nix
    ../../nixos/syncthing.nix
    ../../nixos/tailscale.nix
  ];

  networking = {
    hostName = lib.mkForce "arzuros";
  };
}
