{ config, lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
  ];

  host = {
    class = "laptop";
    gpu = "nvidia";
    session = "hyprland";
    feature.useHome = true;
  };

  hardware.nvidia.package =
    config.boot.kernelPackages.nvidiaPackages.legacy_580;

  networking.hostName = lib.mkForce "arzuros";

  system.stateVersion = "25.11";
}
