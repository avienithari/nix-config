{ lib, osConfig, ... }:

let
  cfg = osConfig.host;
  isHyprlandSession = cfg.isGuiHost && cfg.session == "hyprland";
in
{
  imports = [
    ./hyprland
  ];

  config = lib.mkIf isHyprlandSession {
    wayland.windowManager.hyprland = {
      enable = true;
    };
  };
}
