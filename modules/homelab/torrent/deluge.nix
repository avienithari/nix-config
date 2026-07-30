{ pkgs, inputs, secrets, ... }:

let
  pkgs-stable = import inputs.nixpkgs-stable {
    system = pkgs.stdenv.hostPlatform.system;
  };

  private = import "${secrets}/private.nix";
  domain = private.services.deluge.domain;
  port = private.services.deluge.port;
in
{
  systemd = {
    services = {
      deluged = {
        bindsTo = [ "wg-mullvad.service" ];
        after = [ "wg-mullvad.service" ];
        serviceConfig = {
          NetworkNamespacePath = "/var/run/netns/mullvad";
          BindReadOnlyPaths = [
            "/etc/netns/mullvad/resolv.conf:/etc/resolv.conf"
          ];
          ReadWritePaths = [ "/mnt/downloads" ];
        };
      };

      "proxy-to-deluged" = {
        requires = [
          "deluged.service"
          "proxy-to-deluged.socket"
        ];
        after = [
          "deluged.service"
          "proxy-to-deluged.socket"
        ];
        serviceConfig = {
          User = "deluge";
          Group = "deluge";
          NetworkNamespacePath = "/var/run/netns/mullvad";
          ExecStart =
            let
              proxyd =
                "${pkgs.systemd}/lib/systemd/systemd-socket-proxyd";
            in
            "${proxyd} 127.0.0.1:58846";
        };
      };
    };

    sockets."proxy-to-deluged" = {
      listenStreams = [ "127.0.0.1:58846" ];
      wantedBy = [ "sockets.target" ];
    };
  };

  services = {
    deluge = {
      enable = true;
      package = pkgs-stable.deluge;
      web = {
        enable = true;
        inherit port;
        openFirewall = false;
      };
    };

    caddy.virtualHosts."deluge.${domain}" = {
      useACMEHost = domain;
      extraConfig = ''
        import security_headers
        import lan_only
        reverse_proxy 127.0.0.1:${toString port}
      '';
    };
  };
}
