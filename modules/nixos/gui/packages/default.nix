{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.host.isGuiHost {
    environment.systemPackages = with pkgs; [
      brotli
      discord
      ffmpeg-full
      ffmpeg-headless
      ffmpegthumbnailer
      google-chrome
      libreoffice
      puddletag
      spotify
      tailscale-systray
      vlc
      yt-dlp
    ];
  };
}
