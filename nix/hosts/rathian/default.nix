{ config, lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../modules/adb.nix
    ../../modules/avien.nix
    ../../modules/bluetooth.nix
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
  networking.firewall = {
    allowedTCPPorts = [
      53
      80
      81
      82
      443
      4500
      8123
    ];
    allowedUDPPorts = [
      53
      67
    ];
  };

  avien.tailscale.routingMode = "both";
}
