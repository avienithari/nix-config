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
      feh
      ffmpeg-full
      ffmpeg-headless
      ffmpegthumbnailer
      google-chrome
      puddletag
      signal-desktop
      slack
      spotify
      tailscale-systray
      vlc
      yt-dlp
    ];
  };
}
