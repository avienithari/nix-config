{ config, lib, secrets, ... }:

let
  nutPasswordPath = config.age.secrets.nut-password.path;
  cfg = config.host.feature.nut;
  private = import "${secrets}/private.nix";
  masterAddress = private.services.nut.ip;
  port = private.services.nut.port;
  isMaster = cfg.role == "master";
  isConnected =
    cfg.role == "master" || cfg.role == "standalone";

  nutMode = {
    master = "netserver";
    standalone = "standalone";
    slave = "netclient";
  }.${cfg.role};
in
{
  config = lib.mkIf cfg.enable {
    age.secrets."nut-password".file =
      "${secrets}/nut-password.age";

    power.ups = {
      enable = true;
      mode = nutMode;

      ups = lib.mkIf isConnected {
        main = {
          driver = "usbhid-ups";
          port = "auto";
        };
      };

      upsd = lib.mkIf isConnected {
        enable = true;
        listen = [{
          address =
            if isMaster then "0.0.0.0"
            else "127.0.0.1";
          inherit port;
        }];
      };

      users = lib.mkIf isConnected {
        upsmon = {
          passwordFile = nutPasswordPath;
          upsmon = "primary";
        };
      };

      upsmon.monitor.main = {
        system =
          if isConnected then "main@localhost:${toString port}"
          else "main@${masterAddress}:${toString port}";
        user = "upsmon";
        passwordFile = nutPasswordPath;
        type =
          if isConnected then "primary"
          else "secondary";
      };
    };

    networking.firewall.allowedTCPPorts = lib.mkIf isMaster [ port ];
  };
}
