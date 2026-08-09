{ username, ... }:

{
  services.flameshot = {
    enable = true;
    settings.General = {
      savePath =
        "/home/${username}/pictures/screenshots";
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
