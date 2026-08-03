{ lib, osConfig, ... }:

let
  cfg = osConfig.host;
  isHyprlandSession = cfg.isGuiHost && cfg.session == "hyprland";
  isLaptop = cfg.class == "laptop";
in
lib.mkIf isHyprlandSession {
  wayland.windowManager.hyprland.settings = {
    config = {
      general = {
        border_size = 2;
        gaps_in = 0;
        gaps_out = 1;
        resize_on_border = false;
        col = {
          active_border = {
            colors = [
              "rgba(33ccffee)"
              "rgba(00ff99ee)"
            ];
            angle = 45;
          };
          inactive_border = "rgba(595959aa)";
        };
      };

      decoration = {
        rounding = 0;
        rounding_power = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        blur = {
          enabled = !isLaptop;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
          new_optimizations = true;
        };
        shadow = {
          enabled = !isLaptop;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      misc = {
        disable_hyprland_logo = true;
        middle_click_paste = false;
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      xwayland = {
        enabled = true;
        force_zero_scaling = true;
      };
    };
  };
}
