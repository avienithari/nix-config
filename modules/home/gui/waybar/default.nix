{ pkgs, lib, osConfig, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        mode = "dock";
        spacing = 4;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "custom/separator"
          "cpu"
          "custom/separator"
          "memory"
          "custom/separator"
          "disk"
          "custom/separator"
          "wireplumber"
          "custom/separator"
        ]
        ++ lib.optionals (osConfig.host.class == "laptop") [
          "battery"
          "custom/separator"
          "backlight"
          "custom/separator"
        ]
        ++ [
          "network"
          "bluetooth"
        ];
        "hyprland/workspaces" = {
          on-click = "activate";
          sort-by-number = true;
          persistent-workspaces = { "*" = 10; };
        };
        "clock" = {
          timezone = "Europe/Warsaw";
          format = "{:%I:%M}";
          format-alt = "{:%H:%M %d/%m/%Y}";
          interval = 1;
        };
        "tray" = {
          spacing = 8;
          reverse-direction = true;
        };
        "cpu" = {
          interval = 5;
          format = "CPU: {usage}%";
          format-alt = "CPU: {avg_frequency}GHz";
        };
        "memory" = {
          interval = 5;
          format = "Mem: {used}GiB";
          format-alt = "Mem: {used}/{total}GiB";
        };
        "disk" = {
          interval = 600;
          format = "Disk: {free}";
          path = "/";
          states = {
            warning = 80;
            critical = 90;
          };
        };
        "wireplumber" = {
          max-volume = 100;
          scroll-step = 5;
          format = "{icon} {volume}%";
          format-muted = " {volume}%";
          format-icons = [ "" "" " " ];
        };
        "battery" = {
          interval = 1;
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          states = {
            warning = 20;
            critical = 10;
          };
        };
        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = [ "󰃞" "󰃝" "󰃟" "󰃠" ];
        };
        "network" = {
          format-wifi = "󰖩";
          format-ethernet = "󰈀";
          format-disconnected = "";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        "bluetooth" = {
          format = "󰂲";
          format-on = "{icon}";
          format-off = "";
          format-connected = "{icon}";
          format-icons = {
            on = "󰂯";
            off = "󰂲";
            connected = "󰂱";
          };
        };
        "custom/separator" = {
          format = "|";
          interval = 0;
        };
      };
    };
    style = ''
      @define-color blue #3e8fb0;
      @define-color green #22dd22;

      * {
          font-size: 16px;
          font-family: "JetBrainsMono Nerd Font", monospace;
      }

      window#waybar {
          background-color: black;
          color: white;
      }

      #workspaces button {
          padding: 0 8px;
          color: white;
          background: transparent;
      }

      #workspaces button.active {
          color: #000000;
          background-color: @blue;
      }

      #workspaces button:not(.empty):not(.focused) {
          border-bottom: 3px solid @blue;
      }

      #workspaces button.urgent {
          color: orange;
          font-weight: bold;
      }

      #disk.warning,
      #battery.warning {
          color: orange;
      }

      #disk.critical,
      #battery.critical {
          color: red;
      }

      #battery.charging {
          color: @green;
      }

      #tray,
      #cpu,
      #memory,
      #disk,
      #wireplumber,
      #battery,
      #backlight,
      #network,
      #bluetooth {
          padding: 0 5px;
      }
    '';
  };
}
