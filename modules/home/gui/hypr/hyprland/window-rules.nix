{ lib, osConfig, ... }:

let
  cfg = osConfig.host;
  isHyprlandSession = cfg.isGuiHost && cfg.session == "hyprland";

  mkWindowRule = { prop, effect }: {
    _args = [
      ({ "match" = prop; } // effect)
    ];
  };
in
lib.mkIf isHyprlandSession {
  wayland.windowManager.hyprland.settings = {
    window_rule = [
      (mkWindowRule {
        prop = { class = ".*"; };
        effect = { suppress_event = "maximize"; };
      })
      (mkWindowRule {
        prop = {
          class = "^$";
          title = "^$";
          xwayland = true;
          float = true;
          fullscreen = false;
          pin = false;
        };
        effect = { no_focus = true; };
      })
      (mkWindowRule {
        prop = {
          title = "^(flameshot)$";
        };
        effect = {
          float = true;
          pin = true;
          move = "0 0";
          no_anim = true;
        };
      })
      (mkWindowRule {
        prop = {
          class = "^(?i)(slack)$";
        };
        effect = {
          workspace = "5";
        };
      })
      (mkWindowRule {
        prop = {
          class = "^(?i)(spotify)$";
        };
        effect = {
          workspace = "special:magic";
        };
      })
      (mkWindowRule {
        prop = {
          class = "^(?i)(discord|signal)$";
        };
        effect = {
          workspace = "special:trash";
        };
      })
    ];
  };
}
