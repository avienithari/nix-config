{ pkgs, username, ... }:

let
  flameshot = pkgs.callPackage ./flameshot-pkg.nix { };
in
{
  services.flameshot = {
    enable = true;
    package = flameshot;
    settings.General = {
      savePath =
        "/home/${username}/Pictures/screenshots";
      disabledTrayIcon = true;
      showStartupLaunchMessage = false;
      showDesktopNotification = false;
      showAbortNotification = false;
      showHelp = true;
      showSidePanelButton = true;
      uiColor = "#26233a";
      contrastUiColor = "#f6c177";
      drawColor = "#FF0000";
    };
  };
}
