{ pkgs, ... }:

{
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
    signal-desktop-bin
    slack
    spotify
    tailscale-systray
    vlc
    yt-dlp
  ];
}
