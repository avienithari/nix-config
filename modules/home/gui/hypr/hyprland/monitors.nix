{ lib, osConfig, ... }:

let
  cfg = osConfig.host;
  isHyprlandSession = cfg.isGuiHost && cfg.session == "hyprland";
in
lib.mkIf isHyprlandSession {
  wayland.windowManager.hyprland.settings = {
    monitor = [
      {
        output = "eDP-1";
        mode = "1920x1080@60";
        position = "0x0";
        scale = 1;
      }
      {
        output = "DP-3";
        mode = "3840x2160@60";
        position = "0x0";
        scale = 1.5;
      }
    ];
  };
}
