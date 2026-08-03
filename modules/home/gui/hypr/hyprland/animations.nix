{ lib, osConfig, ... }:

let
  cfg = osConfig.host;
  isHyprlandSession = cfg.isGuiHost && cfg.session == "hyprland";

  mkBeziers = curves: lib.mapAttrsToList
    (name: points: {
      _args = [
        name
        {
          type = "bezier";
          inherit points;
        }
      ];
    })
    curves;

  mkAnims = anims: lib.mapAttrsToList
    (leaf: props: {
      _args = [
        ({
          inherit leaf;
          enabled = true;
        }
        // removeAttrs props [ "curve" ]
        // lib.optionalAttrs (props ? curve) { bezier = props.curve; })
      ];
    })
    anims;
in
lib.mkIf isHyprlandSession {
  wayland.windowManager.hyprland.settings = {
    config = {
      animations = {
        enabled = true;
      };
    };

    curve = mkBeziers {
      easeOutQuint = [ [ 0.23 1.0 ] [ 0.32 1.0 ] ];
      easeInOutCubic = [ [ 0.65 0.05 ] [ 0.36 1.0 ] ];
      linear = [ [ 0.0 0.0 ] [ 1.0 1.0 ] ];
      almostLinear = [ [ 0.5 0.5 ] [ 0.75 1.0 ] ];
      quick = [ [ 0.15 0.0 ] [ 0.1 1.0 ] ];
    };

    animation = mkAnims {
      global = {
        speed = 10;
        curve = "default";
      };
      border = {
        speed = 5.39;
        curve = "easeOutQuint";
      };
      windows = {
        speed = 4.79;
        curve = "easeOutQuint";
      };
      windowsIn = {
        speed = 4.1;
        curve = "easeOutQuint";
        style = "popin 87%";
      };
      windowsOut = {
        speed = 1.49;
        curve = "linear";
        style = "popin 87%";
      };
      fade = {
        speed = 3.03;
        curve = "quick";
      };
      fadeIn = {
        speed = 1.73;
        curve = "almostLinear";
      };
      fadeOut = {
        speed = 1.46;
        curve = "almostLinear";
      };
      layers = {
        speed = 3.81;
        curve = "easeOutQuint";
      };
      layersIn = {
        speed = 4;
        curve = "easeOutQuint";
        style = "fade";
      };
      layersOut = {
        speed = 1.5;
        curve = "linear";
        style = "fade";
      };
      fadeLayersIn = {
        speed = 1.79;
        curve = "almostLinear";
      };
      fadeLayersOut = {
        speed = 1.39;
        curve = "almostLinear";
      };
      workspaces = {
        speed = 1.94;
        curve = "almostLinear";
        style = "fade";
      };
      workspacesIn = {
        speed = 1.21;
        curve = "almostLinear";
        style = "fade";
      };
      workspacesOut = {
        speed = 1.94;
        curve = "almostLinear";
        style = "fade";
      };
    };
  };
}
