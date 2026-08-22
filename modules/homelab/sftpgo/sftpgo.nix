{ secrets, ... }:

let
  private = import "${secrets}/private.nix";
  domain = private.services.sftpgo.domain;
  sftpPort = private.services.sftpgo.sftpPort;
  webPort = private.services.sftpgo.webPort;
in
{
  services = {
    sftpgo = {
      enable = true;

      settings = {
        common = {
          idle_timeout = 15;
          upload_mode = 1;
          defender = {
            enabled = true;
            ban_time = 30;
            ban_time_increment = 50;
            threshold = 5;
            observation_time = 30;
          };
        };

        data_provider = {
          driver = "sqlite";
          name = "/var/lib/sftpgo/sftpgo.db";
        };

        httpd.bindings = [
          {
            port = webPort;
            address = "127.0.0.1";
            enable_web_admin = true;
            enable_web_client = true;
            proxy_allowed = [ "127.0.0.1" ];
          }
        ];

        sftpd = {
          bindings = [{
            port = sftpPort;
            address = "0.0.0.0";
          }];
          max_auth_tries = 3;
        };
      };
    };

    caddy.virtualHosts."files.${domain}" = {
      useACMEHost = domain;
      extraConfig = ''
        import security_headers
        import lan_only
        reverse_proxy 127.0.0.1:${toString webPort}
      '';
    };
  };

  systemd.services.sftpgo = {
    requires = [ "mnt-sftp.automount" ];
    after = [ "mnt-sftp.automount" ];
  };

  networking.firewall.allowedTCPPorts = [ sftpPort ];
}
