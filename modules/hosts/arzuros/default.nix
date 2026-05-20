{ config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../users/avien
  ];

  host = {
    class = "laptop";
    gpu = "nvidia";
    session = "hyprland";
    feature = {
      useHome = true;

      mountSmb = {
        enable = true;
        shares = [ "velvet" ];
      };
    };
  };

  hardware.nvidia.package =
    config.boot.kernelPackages.nvidiaPackages.legacy_580;

  networking.hostName = "arzuros";

  system.stateVersion = "25.11";
}
