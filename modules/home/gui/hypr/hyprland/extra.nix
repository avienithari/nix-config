{ lib, osConfig, ... }:

let
  cfg = osConfig.host;
  isHyprlandSession = cfg.isGuiHost && cfg.session == "hyprland";
in
lib.mkIf isHyprlandSession {
  wayland.windowManager.hyprland.extraConfig = ''
    local MAX_ZOOM = 5
    local MIN_ZOOM = 1

    ---@param offset number
    ---@return nil
    local function zoom(offset)
      local current = hl.get_config("cursor.zoom_factor")

      current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current + offset))
      hl.config({ cursor = { zoom_factor = current } })
    end

    hl.bind("SUPER + SHIFT + mouse_up", function()
      zoom(1)
    end)

    hl.bind("SUPER + SHIFT + mouse_down", function()
      zoom(-1)
    end)
  '';
}
