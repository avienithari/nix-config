{ config, lib, ... }:

{
  imports = [
    ../../modules/adb.nix
    ../../modules/avien.nix
    ../../modules/common-packages.nix
    ../../modules/dev-packages.nix
    ../../modules/gnupg.nix
    ../../modules/maintenance.nix
    ../../modules/nvim.nix
    ../../modules/syncthing.nix
    ./configuration.nix
  ];

  networking.hostName = lib.mkForce "rathian";
}
