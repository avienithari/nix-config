{ config, pkgs, lib, ... }:

with lib;
{
  options.avien.tailscale.routingMode = mkOption {
    type = types.str;
    default = "client";
  };

  config = {
    environment.systemPackages = with pkgs; [
      tailscale
    ];

    services.tailscale = {
      enable = true;
      useRoutingFeatures = config.avien.tailscale.routingMode;
    };
  };
}
