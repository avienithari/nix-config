{ config, lib, pkgs, username, secrets, ... }:

let
  cfg = config.host.feature.mountSmb;
  smbCredsPath = config.age.secrets.smb.path;
  private = import "${secrets}/private.nix";
  nasAddress = private.services.nas.ip;
  shares = private.services.nas.shares;
in
{
  config = lib.mkIf cfg.enable {
    age.secrets."smb".file = "${secrets}/smb.age";

    environment.systemPackages = with pkgs; [ cifs-utils ];

    fileSystems = builtins.listToAttrs (map
      (shareKey: {
        name = "/home/${username}/media/${shareKey}";

        value = {
          device = "//${nasAddress}/${shares.${shareKey}}";
          fsType = "cifs";
          options = [
            "x-systemd.automount"
            "noauto"
            "x-systemd.idle-timeout=60"
            "credentials=${smbCredsPath}"
            "uid=1000"
            "gid=100"
            "_netdev"
          ];
        };
      })
      cfg.shares);
  };
}
