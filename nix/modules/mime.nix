{ config, ... }:

{
  xdg.mime.defaultApplications = {
    "application/pdf" = "brave-browser.desktop";
    "video/mp4" = "vlc.desktop";
  };
}
