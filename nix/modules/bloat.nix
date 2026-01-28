{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    teamviewer
    libreoffice
  ];

  services.teamviewer.enable = true;
}
