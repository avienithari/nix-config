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
    isWorkstation = true;
    gpu = "radeon";
    desktop = "hyprland";

    feature = {
      privateChats = true;
      steam = true;
      torrent = true;
    };
  };

  networking.hostName = lib.mkForce "bazelgeuse";
}
