{ config, lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../services
    ../../nixos
  ];

  host = {
    class = "desktop";
    isGuiHost = true;
    gpu = "nvidia";
    desktop = "gnome";

    feature = {
      steam = true;
      useHome = true;
    };
  };

  hardware.nvidia.package =
    config.boot.kernelPackages.nvidiaPackages.legacy_580;

  networking.hostName = lib.mkForce "zinogre";
}
