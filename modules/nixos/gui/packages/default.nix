{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.host.isGuiHost {
    environment.systemPackages = with pkgs; [
      acpi
      brotli
      discord
      ffmpeg-full
      ffmpeg-headless
      ffmpegthumbnailer
      google-chrome
      libreoffice
      puddletag
      qimgv
      spotify
      tailscale-systray
      vlc
      yt-dlp
    ];
  };
}
