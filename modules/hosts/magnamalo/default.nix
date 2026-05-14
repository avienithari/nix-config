{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../services
    ../../nixos
  ];

  host = {
    class = "laptop";
    isGuiHost = true;
    isWorkstation = true;
    desktop = "hyprland";

    feature = {
      privateChats = true;
      steam = true;
      torrent = true;
      useHome = true;
    };
  };

  networking.hostName = lib.mkForce "magnamalo";
}
