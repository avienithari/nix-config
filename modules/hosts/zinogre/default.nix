{ config, lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
  ];

  host = {
    class = "desktop";
    gpu = "nvidia";
    session = "gnome";

    feature = {
      steam = true;
      useHome = true;
    };
  };

  hardware.nvidia.package =
    config.boot.kernelPackages.nvidiaPackages.legacy_580;

  networking.hostName = lib.mkForce "zinogre";
}
