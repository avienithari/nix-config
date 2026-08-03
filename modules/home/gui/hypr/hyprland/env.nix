{ lib, osConfig, ... }:

let
  cfg = osConfig.host;
  isHyprlandSession = cfg.isGuiHost && cfg.session == "hyprland";
in
lib.mkIf isHyprlandSession {
  wayland.windowManager.hyprland.settings = {
    env = [
      {
        _args = [
          "XCURSOR_THEME"
          "Bibata-Original-Classic"
        ];
      }
      {
        _args = [
          "XCURSOR_SIZE"
          "24"
        ];
      }
    ];
  };
}
