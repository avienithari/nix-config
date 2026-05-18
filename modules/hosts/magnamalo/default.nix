{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../users/avien
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

  networking.hostName = "magnamalo";

  system.stateVersion = "24.11";
}
