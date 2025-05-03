{ config, lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../modules/adb.nix
    ../../modules/avien.nix
    ../../modules/common-packages.nix
    ../../modules/dev-packages.nix
    ../../modules/docker.nix
    ../../modules/gnupg.nix
    ../../modules/maintenance.nix
    ../../modules/nvim.nix
    ../../modules/ssh.nix
    ../../modules/syncthing.nix
    ../../modules/tailscale.nix
  ];

  networking.hostName = lib.mkForce "rathian";

  avien.tailscale.routingMode = "both";
}
