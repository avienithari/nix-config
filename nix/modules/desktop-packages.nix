{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    _1password-gui
    acpi
    brave
    brotli
    calcure
    discord
    feh
    ffmpeg-full
    ffmpeg-headless
    ffmpegthumbnailer
    google-chrome
    httrack
    rpi-imager
    spotify
    vlc
    yt-dlp
  ];
}
