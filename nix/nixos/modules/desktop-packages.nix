{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    _1password-gui-beta
    acpi
    brave
    ffmpeg-full
    gimp
    httrack
    spotify
    vlc
    yt-dlp
  ];
}
