{ config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../users/avien
  ];

  host = {
    class = "desktop";
    gpu = "nvidia";
    session = "gnome";

    feature = {
      steam = true;
      useHome = true;

      mountSmb = {
        enable = true;
        shares = [ "magic" ];
      };
    };
  };

  hardware.nvidia.package =
    config.boot.kernelPackages.nvidiaPackages.legacy_580;

  networking.hostName = "zinogre";

  system.stateVersion = "25.05";
}
