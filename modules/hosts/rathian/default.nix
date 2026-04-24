{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../services
    ../../nixos
    ../../homelab
  ];

  host.feature.docker = true;

  networking.hostName = lib.mkForce "rathian";
  networking.firewall = {
    allowedTCPPorts = [
      80
      443
      4500
      4533
      8123
    ];
  };

  avien.tailscale.routingMode = "both";
}
