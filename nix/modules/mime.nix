{ config, ... }:

{
  xdg.mime.defaultApplications = {
    "application/pdf" = "google-chrome.desktop";
    "video/mp4" = "vlc.desktop";
  };
}
