{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../users/avien
    ../../homelab
  ];

  host = {
    class = "server";

    feature = {
      docker = true;
      useHome = true;
      nut = {
        enable = true;
        role = "master";
      };
    };
  };

  networking.hostName = "rathian";

  services.tailscale.useRoutingFeatures = "both";

  system.stateVersion = "24.11";
}
