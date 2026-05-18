{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
  ];

  host = {
    class = "desktop";
    isWorkstation = true;
    gpu = "radeon";
    session = "hyprland";

    feature = {
      privateChats = true;
      steam = true;
      torrent = true;
      useHome = true;
      virtualisation = true;
    };
  };

  networking.hostName = lib.mkForce "bazelgeuse";

  system.stateVersion = "25.11";
}
