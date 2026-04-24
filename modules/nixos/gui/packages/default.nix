{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.host.isGuiHost {
    environment.systemPackages = with pkgs; [
      _1password-gui
      acpi
      brave
      brotli
      deluge
      discord
      element-desktop
      feh
      ffmpeg-full
      ffmpeg-headless
      ffmpegthumbnailer
      gajim
      google-chrome
      puddletag
      qimgv
      signal-desktop
      slack
      spotify
      tailscale-systray
      vlc
      yt-dlp
    ];
  };
}
