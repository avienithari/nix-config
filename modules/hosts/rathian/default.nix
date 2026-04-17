{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../services
    ../../nixos
  ];

  host.feature.docker = true;

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
