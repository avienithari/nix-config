{ lib, ... }:

{
  options.host = {
    class = lib.mkOption {
      type = lib.types.enum [
        "desktop"
        "laptop"
        "server"
      ];
    };

    isGuiHost = lib.mkEnableOption "Enable host GUI configuration";
    isWorkstation = lib.mkEnableOption "Enable work related packages";

    gpu = lib.mkOption {
      type = lib.types.enum [
        "none"
        "nvidia"
        "radeon"
      ];
      default = "none";
      description = "Dedicated GPU driver";
    };

    desktop = lib.mkOption {
      type = lib.types.enum [
        "none"
        "hyprland"
        "gnome"
      ];
      default = "none";
      description = "Primary desktop environment";
    };

    feature = {
      docker = lib.mkEnableOption "Enable docker virtualisation";
      privateChats = lib.mkEnableOption "Enable additional chat packages";
      steam = lib.mkEnableOption "Enable steam";
      torrent = lib.mkEnableOption "Enable torrent support";
      useHome = lib.mkEnableOption "Enable home-manager configuration";
      virtualisation = lib.mkEnableOption "Enable QEMU/KVM";
    };
  };
}
