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
    desktop = "hyprland";

    feature = {
      privateChats = true;
      steam = true;
      torrent = true;
    };
  };

  networking.hostName = lib.mkForce "magnamalo";
}
