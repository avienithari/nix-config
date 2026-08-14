{ config, pkgs, secrets, ... }:

let
  private = import "${secrets}/private.nix";
  domain = private.services.copyparty.domain;
  port = private.services.copyparty.port;
  users = private.services.copyparty.users;
  userList = builtins.attrValues users;
  workDir = "/mnt/share";

  copypartySrc = fetchTarball {
    url = "https://github.com/9001/copyparty/archive/refs/tags/v1.20.20.tar.gz";
    sha256 = "sha256:1d2dwpipdqv1ysckkaqqmhi6z514c3d17n42fnw26z88m02ass83";
  };

  copypartyPkg =
    pkgs.python3Packages.callPackage
      "${copypartySrc}/contrib/package/nix/copyparty/default.nix"
      { };
in
{
  imports = [
    "${copypartySrc}/contrib/nixos/modules/copyparty.nix"
  ];

  age.secrets = builtins.listToAttrs (map
    (u: {
      name = "copyparty-${u.name}";
      value = {
        file = "${secrets}/${u.secretsFile}";
        owner = "copyparty";
      };
    })
    userList);

  services = {
    copyparty = {
      enable = true;
      package = copypartyPkg;
      user = "copyparty";
      group = "copyparty";
      settings = {
        i = "127.0.0.1";
        p = [ port ];
        theme = 0;
        e2d = true;
        e2ts = true;
        rproxy = 1;
      };

      accounts = builtins.listToAttrs (map
        (u: {
          name = u.name;
          value = {
            passwordFile = config.age.secrets."copyparty-${u.name}".path;
          };
        })
        userList);

      volumes = {
        "/share" = {
          path = workDir + "/share";
          access = {
            rwmd = [
              users.main.name
            ];
            r = [
              users.guest.name
              users.sub.name
            ];
          };
          flags = {
            scan = 60;
            d2t = true;
          };
        };

        "/guest" = {
          path = workDir + "/guest";
          access = {
            rwmd = [
              users.main.name
            ];
            w = [
              users.guest.name
            ];
          };
          flags = {
            fk = 8;
            d2t = true;
          };
        };

        "/sub" = {
          path = workDir + "/sub";
          access = {
            rwmd = [
              users.main.name
            ];
            w = [
              users.sub.name
            ];
          };
          flags = {
            fk = 8;
            d2t = true;
          };
        };
      };
    };

    caddy.virtualHosts."files.${domain}" = {
      useACMEHost = domain;
      extraConfig = ''
        import security_headers
        import lan_only
        reverse_proxy 127.0.0.1:${toString port}
      '';
    };
  };

  systemd.services = {
    copyparty-init = {
      description = "Initialize SMB directories for copyparty";
      before = [ "copyparty.service" ];
      requiredBy = [ "copyparty.service" ];
      serviceConfig = {
        Type = "oneshot";
        User = "copyparty";
        Group = "copyparty";
        RemainAfterExit = true;
      };

      script = ''
        mkdir -p /mnt/share/{share,guest,sub}
      '';
    };

    copyparty.serviceConfig.StateDirectory = "copyparty";
  };
}
