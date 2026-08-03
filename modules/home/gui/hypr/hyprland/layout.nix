{ lib, osConfig, ... }:

let
  cfg = osConfig.host;
  isHyprlandSession = cfg.isGuiHost && cfg.session == "hyprland";
in
lib.mkIf isHyprlandSession {
  wayland.windowManager.hyprland.settings = {
    config = {
      general.layout = "dwindle";
      dwindle.force_split = 1;
    };
  };
}
