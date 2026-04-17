{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.host.isGuiHost && config.host.desktop == "gnome") {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      epiphany
    ];
  };
}
