{ config, lib, ... }:

{
  config = lib.mkIf (config.host.isGuiHost && config.host.session == "hyprland") {
    xdg.mime.defaultApplications = {
      "application/pdf" = "google-chrome.desktop";
      "image/bmp" = "org.gnome.Loupe.desktop";
      "image/gif" = "org.gnome.Loupe.desktop";
      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/jpg" = "org.gnome.Loupe.desktop";
      "image/png" = "org.gnome.Loupe.desktop";
      "image/svg+xml" = "org.gnome.Loupe.desktop";
      "image/tiff" = "org.gnome.Loupe.desktop";
      "image/webp" = "org.gnome.Loupe.desktop";
      "video/mp4" = "vlc.desktop";
    };
  };
}
