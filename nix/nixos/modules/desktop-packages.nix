{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    _1password-gui-beta
    acpi
    brave
    brotli
    ffmpeg-full
    ffmpeg-headless
    ffmpeg-thumbnailer
    gimp
    httrack
    inkscape
    spotify
    vlc
    yt-dlp
  ];
}
