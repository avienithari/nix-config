{ pkgs, lib, osConfig, ... }:

let
  cfg = osConfig.host;
  isWorkDesktop = cfg.isWorkstation && cfg.class == "desktop";

  mullvad = "${pkgs.mullvad}/bin/mullvad";
  seq = "${pkgs.coreutils}/bin/seq";
  wofi = "${pkgs.wofi}/bin/wofi";

  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";

  micStatus = pkgs.writeShellScript "mic-status" ''
    mic=$(${wpctl} get-volume \
    @DEFAULT_AUDIO_SOURCE@ 2>/dev/null)

    if [[ -z "$mic" || "$mic" == *MUTED* ]]; then
      echo ""
    else
      echo "<span color='orange'></span> |"
    fi
  '';

  sunshineWofiRun = pkgs.writeShellScript "sunshine-wofi-run" ''
    if ${systemctl} --user is-active --quiet sunshine; then
      echo "<span color='orange'>󰍹</span> |"
    else
      echo ""
    fi
  '';

  /*
    todos(reminder): remove when waybar officially supports
    switching hyprland ws via new lua dispatcher
  */
  sunshineWofiWs = pkgs.writeShellScript "sunshine-wofi-ws" ''
    case "$1" in
      indicator)
        if ${systemctl} --user is-active --quiet sunshine; then
          echo "<span color='orange'></span> "
        else
          echo ""
        fi
        ;;
      switch)
        choice=$(${seq} 1 10 | \
          ${wofi} --show dmenu --prompt "WS:" \
          --cache-file=/dev/null)

        if [ -n "$choice" ]; then
          ${hyprctl} dispatch "hl.dsp.focus({ workspace = '$choice' })"
        fi
        ;;
    esac
  '';

  vpnStatus = pkgs.writeShellScript "vpn-status" ''
    status=$(${mullvad} status 2>/dev/null)

    if [[ "$status" == *"Connected"* ]]; then
      echo "| <span color='green'>󰦝</span>"
    else
      echo ""
    fi
  '';
in
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
        modules-left = [
          "hyprland/workspaces"
          "custom/vpn"
        ];
        modules-center = [ "clock" ];
        modules-right = lib.optionals isWorkDesktop [
          "custom/wofi-ws"
          "custom/wofi-run"
        ]
        ++ [
          "custom/mic"
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
        ++ lib.optionals (cfg.class == "laptop") [
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
        "custom/vpn" = {
          exec = "${vpnStatus}";
          signal = 9;
          interval = "once";
          format = "{}";
          tooltip = false;
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
        "custom/wofi-ws" = lib.mkIf isWorkDesktop {
          exec = "${sunshineWofiWs} indicator";
          on-click = "${sunshineWofiWs} switch";
          interval = "once";
          signal = 8;
          format = "{}";
          tooltip = false;
        };
        "custom/wofi-run" = lib.mkIf isWorkDesktop {
          exec = "${sunshineWofiRun}";
          on-click = "wofi --show drun";
          interval = "once";
          signal = 8;
          format = "{}";
          tooltip = false;
        };
        "custom/mic" = {
          exec = "${micStatus}";
          interval = 1;
          format = "{}";
          tooltip = false;
        };
        "wireplumber" = {
          max-volume = 100;
          scroll-step = 5;
          format = "{icon} {volume}%";
          format-icons = [ "" "" " " ];
          format-muted = "<span color='orange'> {volume}%</span>";
        };
        "battery" = lib.mkIf (cfg.class == "laptop") {
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
        "backlight" = lib.mkIf (cfg.class == "laptop") {
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

      #custom-vpn,
      #custom-mic,
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

      .modules-right {
        margin-right: 8px;
      }
    '';
  };
}
