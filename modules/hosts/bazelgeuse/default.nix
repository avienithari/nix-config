{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../services
    ../../nixos
  ];

  host = {
    isGuiHost = true;
    gpu = "radeon";
    desktop = "hyprland";

    feature = {
      bloat = true;
      steam = true;
    };
  };

  networking.hostName = lib.mkForce "bazelgeuse";
}
