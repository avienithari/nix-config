{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.host.isGuiHost && config.host.session == "hyprland") {
    environment.systemPackages = with pkgs; [
      bibata-cursors
      brightnessctl
      grim
      hyprland
      hyprlock
      hyprpaper
      hyprsunset
      loupe
      playerctl
      rofi
      wl-clipboard
    ];

    environment.variables = { XDG_SESSION_TYPE = "wayland"; };
    programs.hyprland.enable = true;

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    programs.thunar.enable = true;
    services = {
      gvfs.enable = true;
      tumbler.enable = true;
    };
  };
}
