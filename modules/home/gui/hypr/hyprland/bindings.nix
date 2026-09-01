{ lib, osConfig, ... }:

let
  cfg = osConfig.host;
  isHyprlandSession = cfg.isGuiHost && cfg.session == "hyprland";

  mkBind = { key, cmd, opts ? { } }: {
    _args = [
      key
      (lib.generators.mkLuaInline cmd)
      opts
    ];
  };

  mainMod = "SUPER";
  terminal = "ghostty";
  fileManager = "thunar";
  menu = "pkill wofi || wofi --show drun";
in
lib.mkIf isHyprlandSession {
  wayland.windowManager.hyprland.settings = {
    bind = [
      (mkBind {
        key = "${mainMod} + CTRL + SHIFT + m";
        cmd = "hl.dsp.exit()";
      })
      (mkBind {
        key = "${mainMod} + q";
        cmd = "hl.dsp.window.close()";
      })
      (mkBind {
        key = "${mainMod} + Return";
        cmd = "hl.dsp.exec_cmd('${terminal}')";
      })
      (mkBind {
        key = "${mainMod} + e";
        cmd = "hl.dsp.exec_cmd('${fileManager}')";
      })
      (mkBind {
        key = "${mainMod} + space";
        cmd = "hl.dsp.exec_cmd('${menu}')";
      })
      (mkBind {
        key = "${mainMod} + Escape";
        cmd = "hl.dsp.exec_cmd('hyprlock')";
      })
      (mkBind {
        key = "Print";
        cmd =
          "hl.dsp.exec_cmd('flameshot gui --clipboard --accept-on-select')";
      })
      (mkBind {
        key = "SHIFT + Print";
        cmd = "hl.dsp.exec_cmd('flameshot gui')";
      })
      (mkBind {
        key = "F20";
        cmd =
          "hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle')";
      })
      (mkBind {
        key = "${mainMod} + v";
        cmd = "hl.dsp.window.float()";
      })
      (mkBind {
        key = "${mainMod} + f";
        cmd = "hl.dsp.window.fullscreen()";
      })
      (mkBind {
        key = "${mainMod} + h";
        cmd = "hl.dsp.focus({ direction = 'left' })";
      })
      (mkBind {
        key = "${mainMod} + l";
        cmd = "hl.dsp.focus({ direction = 'right' })";
      })
      (mkBind {
        key = "${mainMod} + k";
        cmd = "hl.dsp.focus({ direction = 'up' })";
      })
      (mkBind {
        key = "${mainMod} + j";
        cmd = "hl.dsp.focus({ direction = 'down' })";
      })
      (mkBind {
        key = "${mainMod} + CTRL + h";
        cmd = "hl.dsp.window.swap({ direction = 'left' })";
      })
      (mkBind {
        key = "${mainMod} + CTRL + l";
        cmd = "hl.dsp.window.swap({ direction = 'right' })";
      })
      (mkBind {
        key = "${mainMod} + CTRL + k";
        cmd = "hl.dsp.window.swap({ direction = 'up' })";
      })
      (mkBind {
        key = "${mainMod} + CTRL + j";
        cmd = "hl.dsp.window.swap({ direction = 'down' })";
      })
      (mkBind {
        key = "${mainMod} + SHIFT + h";
        cmd = "hl.dsp.window.move({ direction = 'left' })";
      })
      (mkBind {
        key = "${mainMod} + SHIFT + l";
        cmd = "hl.dsp.window.move({ direction = 'right' })";
      })
      (mkBind {
        key = "${mainMod} + SHIFT + k";
        cmd = "hl.dsp.window.move({ direction = 'up' })";
      })
      (mkBind {
        key = "${mainMod} + SHIFT + j";
        cmd = "hl.dsp.window.move({ direction = 'down' })";
      })
      (mkBind {
        key = "${mainMod} + CTRL + SHIFT + h";
        cmd = "hl.dsp.window.resize({ x = -30, y = 0, relative = true })";
        opts = { repeating = true; };
      })
      (mkBind {
        key = "${mainMod} + CTRL + SHIFT + l";
        cmd = "hl.dsp.window.resize({ x = 30, y = 0, relative = true })";
        opts = { repeating = true; };
      })
      (mkBind {
        key = "${mainMod} + CTRL + SHIFT + k";
        cmd = "hl.dsp.window.resize({ x = 0, y = -30, relative = true })";
        opts = { repeating = true; };
      })
      (mkBind {
        key = "${mainMod} + CTRL + SHIFT + j";
        cmd = "hl.dsp.window.resize({ x = 0, y = 30, relative = true })";
        opts = { repeating = true; };
      })
      (mkBind {
        key = "${mainMod} + s";
        cmd = "hl.dsp.workspace.toggle_special('magic')";
      })
      (mkBind {
        key = "${mainMod} + SHIFT + s";
        cmd = "hl.dsp.window.move({ workspace = 'special:magic' })";
      })
      (mkBind {
        key = "${mainMod} + d";
        cmd = "hl.dsp.workspace.toggle_special('trash')";
      })
      (mkBind {
        key = "${mainMod} + SHIFT + d";
        cmd = "hl.dsp.window.move({ workspace = 'special:trash' })";
      })
      (mkBind {
        key = "${mainMod} + mouse_down";
        cmd = "hl.dsp.focus({ workspace = 'e+1' })";
      })
      (mkBind {
        key = "${mainMod} + mouse_up";
        cmd = "hl.dsp.focus({ workspace = 'e-1' })";
      })
      (mkBind {
        key = "${mainMod} + mouse:272";
        cmd = "hl.dsp.window.drag()";
      })
      (mkBind {
        key = "${mainMod} + mouse:273";
        cmd = "hl.dsp.window.resize()";
      })
      (mkBind {
        key = "XF86AudioRaiseVolume";
        cmd =
          "hl.dsp.exec_cmd('wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+')";
        opts = {
          locked = true;
          repeating = true;
        };
      })
      (mkBind {
        key = "XF86AudioLowerVolume";
        cmd = "hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-')";
        opts = {
          locked = true;
          repeating = true;
        };
      })
      (mkBind {
        key = "XF86AudioMute";
        cmd = "hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle')";
        opts = {
          locked = true;
          repeating = true;
        };
      })
      (mkBind {
        key = "XF86AudioMicMute";
        cmd =
          "hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle')";
        opts = {
          locked = true;
          repeating = true;
        };
      })
      (mkBind {
        key = "XF86MonBrightnessUp";
        cmd = "hl.dsp.exec_cmd('brightnessctl s 5%+')";
        opts = {
          locked = true;
          repeating = true;
        };
      })
      (mkBind {
        key = "XF86MonBrightnessDown";
        cmd = "hl.dsp.exec_cmd('brightnessctl s 5%-')";
        opts = {
          locked = true;
          repeating = true;
        };
      })
      (mkBind {
        key = "XF86AudioNext";
        cmd = "hl.dsp.exec_cmd('playerctl next')";
        opts = { locked = true; };
      })
      (mkBind {
        key = "XF86AudioPause";
        cmd = "hl.dsp.exec_cmd('playerctl play-pause')";
        opts = { locked = true; };
      })
      (mkBind {
        key = "XF86AudioPlay";
        cmd = "hl.dsp.exec_cmd('playerctl play-pause')";
        opts = { locked = true; };
      })
      (mkBind {
        key = "XF86AudioPrev";
        cmd = "hl.dsp.exec_cmd('playerctl previous')";
        opts = { locked = true; };
      })
    ]
    ++ builtins.concatLists (map
      (ws:
        let
          wsStr = toString ws;
          key = if wsStr == "10" then "0" else toString ws;
        in
        [
          (mkBind {
            key = "${mainMod} + ${key}";
            cmd = "hl.dsp.focus({ workspace = ${wsStr} })";
          })
          (mkBind {
            key = "${mainMod} + SHIFT + ${key}";
            cmd =
              "hl.dsp.window.move({ workspace = ${wsStr}, follow = true })";
          })
        ]
      )
      (builtins.genList (x: x + 1) 10));
  };
}
