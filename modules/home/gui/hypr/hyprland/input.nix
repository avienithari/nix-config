{ lib, osConfig, ... }:

let
  cfg = osConfig.host;
  isHyprlandSession = cfg.isGuiHost && cfg.session == "hyprland";
in
lib.mkIf isHyprlandSession {
  wayland.windowManager.hyprland.settings = {
    config.input = {
      kb_model = "";
      kb_layout = "pl";
      kb_variant = "";
      kb_options = "";
      kb_rules = "";
      sensitivity = 0;
      follow_mouse = 1;
      touchpad.natural_scroll = true;
    };
  };
}
