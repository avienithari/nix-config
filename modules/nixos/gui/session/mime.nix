{ config, lib, ... }:

let
  cfg = config.host;
  isHyprlandSession = cfg.isGuiHost && cfg.session == "hyprland";
in
{
  config = lib.mkIf isHyprlandSession {
    xdg.mime.defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "image/bmp" = "org.gnome.Loupe.desktop";
      "image/gif" = "org.gnome.Loupe.desktop";
      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/jpg" = "org.gnome.Loupe.desktop";
      "image/png" = "org.gnome.Loupe.desktop";
      "image/svg+xml" = "org.gnome.Loupe.desktop";
      "image/tiff" = "org.gnome.Loupe.desktop";
      "image/webp" = "org.gnome.Loupe.desktop";
      "text/markdown" = "nvim-gui.desktop";
      "text/plain" = "nvim-gui.desktop";
      "video/mp4" = "vlc.desktop";
    };
  };
}
