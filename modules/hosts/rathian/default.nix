{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../nixos/adb.nix
    ../../nixos/avien.nix
    ../../nixos/bluetooth.nix
    ../../nixos/common-packages.nix
    ../../nixos/dev-packages.nix
    ../../nixos/docker.nix
    ../../nixos/gnupg.nix
    ../../nixos/locale.nix
    ../../nixos/maintenance.nix
    ../../nixos/nvim.nix
    ../../nixos/ssh.nix
    ../../nixos/syncthing.nix
    ../../nixos/tailscale.nix
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
      4533
      8123
    ];
    allowedUDPPorts = [
      53
      67
    ];
  };

  avien.tailscale.routingMode = "both";
}
