{ lib, osConfig, ... }:

let
  cfg = osConfig.host;
  isHyprlandSession = cfg.isGuiHost && cfg.session == "hyprland";
in
{
  imports = [
    ./hyprland
    ./hyprlock
    ./hyprpaper
    ./hyprsunset
  ];

  config = lib.mkIf isHyprlandSession {
    wayland.windowManager.hyprland = {
      enable = true;
    };
  };
}
