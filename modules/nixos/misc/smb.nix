{ config, lib, pkgs, username, secrets, ... }:

let
  cfg = config.host.feature.mountSmb;
  private = import "${secrets}/private.nix";
  nasAddress = private.services.nas.ip;
  shares = private.services.nas.shares;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ cifs-utils ];

    age.secrets = builtins.listToAttrs (map
      (shareKey: {
        name = "${shareKey}";
        value.file = "${secrets}/${shares.${shareKey}.secretsFile}";
      })
      cfg.shares);

    fileSystems = builtins.listToAttrs (map
      (shareKey: {
        name = "/home/${username}/media/${shareKey}";
        value = {
          device = "//${nasAddress}/${shares.${shareKey}.share}";
          fsType = "cifs";
          options = [
            "x-systemd.automount"
            "noauto"
            "x-systemd.idle-timeout=60"
            "credentials=${config.age.secrets."${shareKey}".path}"
            "uid=1000"
            "gid=100"
            "_netdev"
          ];
        };
      })
      cfg.shares);
  };
}
