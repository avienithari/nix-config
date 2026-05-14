{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.host.isGuiHost && config.host.session == "gnome") {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = with pkgs; [
      decibels
      epiphany
      evolution-data-server
      gnome-characters
      gnome-clocks
      gnome-connections
      gnome-contacts
      gnome-font-viewer
      gnome-maps
      gnome-music
      gnome-online-accounts
      gnome-tour
      gnome-weather
      showtime
      simple-scan
      snapshot
      totem
      yelp
    ];
  };
}
