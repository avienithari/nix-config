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
    isWorkstation = true;
    session = "hyprland";

    feature = {
      privateChats = true;
      steam = true;
      torrent = true;
      useHome = true;
    };
  };

  networking.hostName = lib.mkForce "magnamalo";
}
