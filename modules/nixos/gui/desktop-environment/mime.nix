{ config, lib, ... }:

{
  config = lib.mkIf (config.host.isGuiHost && config.host.desktop == "hyprland") {
    xdg.mime.defaultApplications = {
      "application/pdf" = "google-chrome.desktop";
      "video/mp4" = "vlc.desktop";
    };
  };
}
