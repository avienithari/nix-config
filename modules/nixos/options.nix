{ config, lib, ... }:

{
  options.host = {
    class = lib.mkOption {
      type = lib.types.enum [
        "desktop"
        "laptop"
        "server"
      ];
      description = "Define host class";
    };

    isGuiHost = lib.mkOption {
      type = lib.types.bool;
      description = "Enable host GUI configuration";
    };

    isWorkstation = lib.mkEnableOption "Enable work related packages";

    gpu = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum [
        "nvidia"
        "radeon"
      ]);
      description = "Dedicated GPU driver";
    };

    session = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum [
        "hyprland"
        "gnome"
      ]);
      description = "Graphical session";
    };

    feature = {
      docker = lib.mkEnableOption "Enable docker virtualisation";
      privateChats = lib.mkEnableOption "Enable additional chat packages";
      steam = lib.mkEnableOption "Enable steam";
      syncthingWebUi = lib.mkEnableOption "Enable syncthing web ui";
      torrent = lib.mkEnableOption "Enable torrent support";
      useHome = lib.mkEnableOption "Enable home-manager configuration";
      virtualisation = lib.mkEnableOption "Enable QEMU/KVM";

      nut = {
        enable = lib.mkEnableOption "Enable NUT";

        role = lib.mkOption {
          type = lib.types.enum [
            "master"
            "slave"
          ];

          default = "slave";
        };
      };

      mountSmb = {
        enable = lib.mkEnableOption "Enable smb shares";

        shares = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          description = "List of share names to mount";
        };
      };
    };
  };

  config.host.isGuiHost = lib.mkDefault
    (config.host.class == "desktop" || config.host.class == "laptop");
}
