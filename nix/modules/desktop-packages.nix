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
    signal-desktop-bin
    slack
    spotify
    tailscale-systray
    vlc
    yt-dlp
  ];
}
