{ ... }:

{
  imports = [
    ./hardware-configuration.nix
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
      useZsa = true;
      virtualisation = true;

      mountSmb = {
        enable = true;
        shares = [
          "dragon"
          "magic"
          "velvet"
        ];
      };

      nut = {
        enable = true;
        role = "standalone";
      };
    };
  };

  networking.hostName = "bazelgeuse";

  system.stateVersion = "25.11";
}
