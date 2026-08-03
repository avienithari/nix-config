{ lib, osConfig, ... }:

let
  cfg = osConfig.host;
  isHyprlandSession = cfg.isGuiHost && cfg.session == "hyprland";

  mkAutoStart = { event, cmd }: {
    _args = [
      event
      (lib.generators.mkLuaInline
        "function()\n hl.exec_cmd('${cmd}')\nend")
    ];
  };
in
lib.mkIf isHyprlandSession {
  wayland.windowManager.hyprland.settings = {
    on = [
      (mkAutoStart {
        event = "hyprland.start";
        cmd = "waybar";
      })
      (mkAutoStart {
        event = "hyprland.start";
        cmd = "hyprpaper";
      })
      (mkAutoStart {
        event = "hyprland.start";
        cmd = "hyprsunset";
      })
      (mkAutoStart {
        event = "hyprland.start";
        cmd = "tailscale-systray";
      })
    ];
  };
}
