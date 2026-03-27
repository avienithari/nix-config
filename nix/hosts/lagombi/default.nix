{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../modules/avien.nix
    ../../modules/bluetooth.nix
    ../../modules/common-packages.nix
    ../../modules/desktop-packages.nix
    ../../modules/dev-packages.nix
    ../../modules/fonts.nix
    ../../modules/gnome.nix
    ../../modules/gnupg.nix
    ../../modules/maintenance.nix
    ../../modules/nvidia.nix
    ../../modules/ssh.nix
    ../../modules/syncthing.nix
  ];

  networking = {
    hostName = lib.mkForce "lagombi";
  };
}
