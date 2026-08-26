{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.homelab.per-service-smb;
  private = import "${secrets}/private.nix";
  nasAddress = private.services.nas.ip;
in
{
  options.homelab.per-service-smb = lib.mkOption {
    description = "Mount smb share for corresponding service";
    default = { };
    type = lib.types.attrsOf (lib.types.submodule ({ name, ... }: {
      options = {
        share = lib.mkOption {
          type = lib.types.attrs;
        };
        uid = lib.mkOption {
          type = lib.types.str;
        };
        gid = lib.mkOption {
          type = lib.types.str;
          default = "users";
        };
        mountPoint = lib.mkOption {
          type = lib.types.str;
          default = "/mnt/${name}";
        };
      };
    }));
  };

  config = lib.mkIf (cfg != { }) {
    environment.systemPackages = with pkgs; [ cifs-utils ];

    age.secrets = lib.mapAttrs'
      (name: val:
        let
          secretName = "rathian-${name}-smb";
        in
        lib.nameValuePair secretName {
          file = "${secrets}/${val.share.secretsFile}";
        }
      )
      cfg;

    fileSystems = lib.mapAttrs'
      (name: val:
        let
          secretName = "rathian-${name}-smb";
          credsPath = config.age.secrets.${secretName}.path;
        in
        lib.nameValuePair val.mountPoint {
          device = "//${nasAddress}/${val.share.shareName}";
          fsType = "cifs";
          options = [
            "x-systemd.automount"
            "noauto"
            "x-systemd.idle-timeout=60"
            "credentials=${credsPath}"
            "uid=${val.uid}"
            "gid=${val.gid}"
            "dir_mode=0770"
            "file_mode=0660"
            "_netdev"
          ];
        }
      )
      cfg;
  };
}
