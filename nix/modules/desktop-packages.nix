{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    _1password-gui
    acpi
    brave
    brotli
    discord
    feh
    ffmpeg-full
    ffmpeg-headless
    ffmpegthumbnailer
    google-chrome
    httrack
    kdePackages.dolphin
    rpi-imager
    spotify
    vlc
    yt-dlp
  ];
}
