{ lib, ... }:

{
  options.host = {
    isGuiHost = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable host GUI configuration";
    };

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
  };
}
