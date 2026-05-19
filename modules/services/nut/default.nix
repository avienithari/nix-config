{ config, lib, secrets, ... }:

let
  nutPasswordPath = config.age.secrets.nut-password.path;
  cfg = config.host.feature.nut;
  isMaster = cfg.role == "master";
  private = import "${secrets}/private.nix";
  masterAddress = private.services.nut.ip;
  port = private.services.nut.port;
in
{
  config = lib.mkIf cfg.enable {
    age.secrets."nut-password".file = "${secrets}/nut-password.age";

    power.ups = {
      enable = true;
      mode = if isMaster then "netserver" else "netclient";

      ups = lib.mkIf isMaster {
        main = {
          driver = "usbhid-ups";
          port = "auto";
        };
      };

      upsd = lib.mkIf isMaster {
        enable = true;
        listen = [{
          address = "0.0.0.0";
          inherit port;
        }];
      };

      users = lib.mkIf isMaster {
        upsmon = {
          passwordFile = nutPasswordPath;
          upsmon = "primary";
        };
      };

      upsmon.monitor = {
        main = {
          system =
            if isMaster then "main@localhost:${toString port}"
            else "main@${masterAddress}:${toString port}";
          user = "upsmon";
          passwordFile = nutPasswordPath;
          type = if isMaster then "primary" else "secondary";
        };
      };
    };

    networking.firewall.allowedTCPPorts = lib.mkIf isMaster [ port ];
  };
}
