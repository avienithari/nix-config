{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    _1password-gui
    acpi
    brave
    brotli
    feh
    ffmpeg-full
    ffmpeg-headless
    ffmpegthumbnailer
    gimp
    httrack
    inkscape
    kdePackages.dolphin
    spotify
    vlc
    yt-dlp
  ];
}
