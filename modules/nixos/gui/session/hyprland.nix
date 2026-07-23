{ config, lib, pkgs, ... }:

let
  cfg = config.host;
  isHyprlandSession = cfg.isGuiHost && cfg.session == "hyprland";
in
{
  config = lib.mkIf isHyprlandSession {
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
      zathura

      (makeDesktopItem {
        name = "nvim-gui";
        icon = "nvim";
        desktopName = "Neovim GUI";
        exec = "ghostty -e nvim %F";
        terminal = false;
        mimeTypes = [
          "text/markdown"
          "text/plain"
        ];
      })
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
