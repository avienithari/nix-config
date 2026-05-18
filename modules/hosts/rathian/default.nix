{ ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../homelab
  ];

  host = {
    class = "server";

    feature = {
      docker = true;
      useHome = true;
    };
  };

  networking = {
    hostName = "rathian";
    firewall = {
      allowedTCPPorts = [
        80
        443
        4500
        4533
        8123
      ];
    };
  };

  services.tailscale.useRoutingFeatures = "both";

  system.stateVersion = "24.11";
}
