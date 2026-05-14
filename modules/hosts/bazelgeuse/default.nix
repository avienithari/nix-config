{ lib, ... }:

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
    isWorkstation = true;
    gpu = "radeon";
    desktop = "hyprland";

    feature = {
      privateChats = true;
      steam = true;
      torrent = true;
      useHome = true;
      virtualisation = true;
    };
  };

  networking.hostName = lib.mkForce "bazelgeuse";
}
