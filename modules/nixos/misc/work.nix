{ config, lib, pkgs, username, ... }:

let
  isWorkstation = config.host.isWorkstation;
  isDesktop = config.host.class == "desktop";
  isLaptop = config.host.class == "laptop";
in
{
  config = lib.mkMerge [
    (lib.mkIf isWorkstation {
      environment.systemPackages = with pkgs; [
        brave
        slack
      ];
    })

    (lib.mkIf (isWorkstation && isLaptop) {
      environment.systemPackages = with pkgs; [
        moonlight-qt
      ];
    })

    (lib.mkIf (isWorkstation && isDesktop) {
      services.sunshine = {
        enable = true;
        autoStart = false;
        capSysAdmin = true;
        openFirewall = false;

        applications.apps = [
          {
            name = "Desktop";
          }
        ];
      };

      boot = {
        kernelModules = [ "uinput" ];
        kernel.sysctl = {
          "net.ipv4.ip_local_reserverd_ports" = "47984-48010";
        };
      };

      hardware.graphics.enable = true;
      users.users.${username}.extraGroups = [ "uinput" ];

      networking.firewall.interfaces = {
        "enp7s0" = {
          allowedTCPPorts = [
            47984
            47989
            48010
          ];
          allowedUDPPortRanges = [
            {
              from = 47998;
              to = 48000;
            }
          ];
        };

        "tailscale0" = {
          allowedTCPPorts = [
            47984
            47989
            48010
          ];
          allowedUDPPortRanges = [
            {
              from = 47998;
              to = 48000;
            }
          ];
        };
      };
    })
  ];
}
