{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    _1password-gui-beta
    acpi
    brave
    brotli
    kdePackages.dolphin
    ffmpeg-full
    ffmpeg-headless
    ffmpegthumbnailer
    gimp
    httrack
    inkscape
    spotify
    vlc
    yt-dlp
  ];
}
