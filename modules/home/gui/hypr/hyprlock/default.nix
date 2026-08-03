{ ... }:

let
  leavesWallpaper = ../assets/leaves.jpg;

  colors = {
    text = "rgba(242, 243, 244, 0.75)";
    input = {
      auth = "rgb(204, 136, 34)";
      bg = "rgba(252, 252, 252, 0.2)";
      border = "rgba(252, 252, 252, 1.0)";
      font = "black";
      placeholder = "##cdd6f4";
    };
  };

  clock = "cmd[update:1000] echo \"$(date +\"%-I:%M\")\"";
  date =
    "cmd[update:1000] echo \"$(LC_TIME=en_US.UTF-8 date +\"%A, %B %d\")\"";
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 0;
        no_fade_in = true;
        no_fade_out = true;
        hide_cursor = true;
        disable_loading_bar = true;
      };

      background = [
        {
          monitor = "";
          path = "${leavesWallpaper}";
          blur_passes = 2;
          contrast = 1;
          brightness = 0.5;
          vibrancy = 0.2;
          vibrancy_darkness = 0.2;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          outer_color = "${colors.input.border}";
          inner_color = "${colors.input.bg}";
          font_color = "${colors.input.font}";
          fade_on_empty = false;
          rounding = -1;
          check_color = "${colors.input.auth}";
          placeholder_text =
            "<i><span foreground='${colors.input.placeholder}'>"
            + "Input Password...</span></i>";
          hide_input = false;
          position = " 0, -200";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "${date}";
          color = "${colors.text}";
          font_size = 22;
          font_family = "JetBrains Mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "${clock}";
          color = "${colors.text}";
          font_size = 95;
          font_family = "JetBrains Mono Extrabold";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
