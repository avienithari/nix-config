{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    burpsuite
    teamviewer
    libreoffice
  ];

  services.teamviewer.enable = true;
}
